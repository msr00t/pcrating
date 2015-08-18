class Game < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  require 'net/http'

  RANSACKABLE_ATTRIBUTES = %w(title)
  RANSACKABLE_ASSOCIATIONS = %w(developers publishers genres platforms categories)
  RANSORTABLE_ATTRIBUTES = %w(cached_score title release_date cached_reviews_total)

  serialize :data
  serialize :dlc

  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  [
    'genre', 'publisher',
    'developer', 'platform',
    'category'
  ].each do |relation|
    intermediates = "#{relation}_games".to_sym
    relations = "#{relation.pluralize}".to_sym
    has_many intermediates, dependent: :destroy
    has_many relations, through: intermediates
  end

  belongs_to :user

  validates :steam_appid, uniqueness: true

  before_save :update_cached_data
  before_create :request_game_data
  after_create :copy_genres
  after_create :copy_categories
  after_create :copy_publishers
  after_create :copy_developers
  after_create :copy_platforms

  scope :top, -> { order(cached_score: :desc) }
  scope :bottom, -> { rated.order(cached_score: :asc) }
  scope :with_release_date, -> { where.not(release_date: nil) }
  scope :latest, -> { order(release_date: :desc).with_release_date }
  scope :rated, -> { where('games.id IN (SELECT DISTINCT(game_id) FROM reviews)') }

  # Class

  def self.recalculate_scores
    find_each(&:save)
  end

  # Stats

  def rank
    cached_rank
  end

  def score
    cached_score
  end

  def stats
    Reviews::GameRanker.new(self).stat_hash
  end

  def update_cached_data
    ranker = Reviews::GameRanker.new(self)
    self.cached_score = ranker.score
    self.cached_rank = ranker.rank
    self.cached_reviews_total = self.reviews.size
  end

  # Static Data

  def requirements(platform, level)
    return false unless data

    platform_hash = data["#{platform}_requirements"]
    return false if platform_hash.empty?
    req = platform_hash[level]
    return req.html_safe if req
  end

  def has_category?(category)
    categories.map { |category| category.name }.include? category
  end

  def launch_game_link
    "steam://run/#{steam_appid}"
  end

  def store_link
    "http://store.steampowered.com/app/#{steam_appid}/"
  end

  def rated_by_user?(user)
    return false unless user

    rating = Review.find_by(user_id: user.id, game_id: id)

    return true if rating
  end

  def force_update!(opts = {})
    if opts[:hit_api]
      request_game_data
    else
      # We changed how we stored the data hash, we need to make sure that
      # the row has properly been converted
      ensure_correct_data_hash
      copy_data
    end
    copy_genres
    copy_categories
    copy_publishers
    copy_developers
    copy_platforms
    save
  end

  private

    def ensure_correct_data_hash
      if self.data.keys[0] == self.steam_appid.to_s
        self.data = self.data[steam_appid.to_s]['data']
      end
    end

    def request_game_data
      url = "http://store.steampowered.com/api/appdetails/?appids=#{steam_appid}"
      resp = Net::HTTP.get_response(URI.parse(url))
      data = JSON.parse(resp.body)

      if data[steam_appid.to_s]['data'].blank? || resp.code == '403'
        errors.add :Game, 'does not exist'
        return false
      end

      self.data = data[steam_appid.to_s]['data']

      copy_data
    end

    # Copy data out of the data parcel returned
    # by the Steam API into the Game model's fields
    def copy_data
      self.title = data['name']
      self.dlc = data['dlc']
      self.header_image = data['header_image']
      self.website = data['website']
      self.background_image = data['background_image']
      self.detailed_description = data['detailed_description']
      copy_date
    end

    def copy_platforms
      platforms = []
      data['platforms'].each do |platform, platform_supported|
        next unless platform_supported
        platforms.push platform
      end
      self.platforms = platforms
    end

    def copy_date
      date_string = data['release_date']['date']

      unless date_string.blank?
        formats = ["%d %b, %Y", "%b %d, %Y", "%b %Y"]

        date_obj = false
        formats.each do |format|
          date_obj = Date.strptime(date_string, format) rescue nil
          break if date_obj
        end

        if date_obj
          self.release_date = date_obj
        else
          puts "Date format unknown: #{date_string}"
        end
      end
    end

    def copy_genres
      genres = data['genres']

      return false unless genres

      genres.each do |genre_hash|
        genre_model = Genre.find_or_create_by(name: genre_hash['description'])
        GenreGame.find_or_create_by(game: self, genre: genre_model)
      end
    end

    def copy_categories
      categories = data['categories']

      return false unless categories

      categories.each do |category_hash|
        category_model = Category.find_or_create_by(name: category_hash['description'])
        CategoryGame.find_or_create_by(game: self, category: category_model)
      end
    end

    def copy_developers
      developers = data['developers']

      return false unless developers

      developers.each do |developer|
        developer_model = Developer.find_or_create_by(name: developer)
        DeveloperGame.find_or_create_by(game: self, developer: developer_model)
      end
    end

    def copy_publishers
      publishers = data['publishers']

      return false unless publishers

      publishers.each do |publisher|
        publisher_model = Publisher.find_or_create_by(name: publisher)
        PublisherGame.find_or_create_by(game: self, publisher: publisher_model)
      end
    end

    def copy_platforms
      platforms = data['platforms']

      return false unless platforms

      platforms.each do |platform, valid_platform|
        next unless valid_platform
        platform_model = Platform.find_or_create_by(name: platform)
        PlatformGame.find_or_create_by(game: self, platform: platform_model)
      end
    end

    def self.ransackable_attributes(auth_object = nil)
      return super if auth_object == :admin
      super & RANSACKABLE_ATTRIBUTES
    end

    def self.ransackable_associations(auth_object = nil)
      return super if auth_object == :admin
      super & RANSACKABLE_ASSOCIATIONS
    end

    def self.ransortable_attributes(auth_object = nil)
      return super if auth_object == :admin
      RANSORTABLE_ATTRIBUTES
    end

end