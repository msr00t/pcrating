# A game on the site
# TODO: Pull out all the data requesting and data copying into a service
#       There is way too much going on here
class Game < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  require 'net/http'

  RANSACKABLE_ATTRIBUTES = %w(title)
  RANSACKABLE_ASSOCIATIONS = %w(developers publishers
                                genres platforms categories)
  RANSORTABLE_ATTRIBUTES = %w(cached_score title release_date
                              cached_reviews_total)

  serialize :data
  serialize :dlc

  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  %w( genre publisher
      developer platform
      category).each do |relation|
    intermediates = "#{relation}_games".to_sym
    relations = "#{relation.pluralize}".to_sym
    has_many intermediates, dependent: :destroy
    has_many relations, through: intermediates
  end

  belongs_to :user

  validates :steam_appid, uniqueness: true

  before_save :update_cached_data
  before_create :update_game_data
  after_create :create_relations

  scope :top,
        -> { rated.order(cached_score: :desc).limit(2) }
  scope :bottom,
        -> { rated.order(cached_score: :asc).limit(2) }
  scope :with_release_date,
        -> { where.not(release_date: nil) }
  scope :latest,
        -> { order(release_date: :desc).with_release_date.limit(2) }
  scope :rated,
        -> { where('games.id IN (SELECT DISTINCT(game_id) FROM reviews)') }

  # Class

  def self.recalculate_scores
    find_each(&:save)
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
    self.cached_reviews_total = reviews.visible.size
  end

  # Static Data

  def requirements(platform, level)
    return false unless data

    platform_hash = data["#{platform}_requirements"]
    return false if platform_hash.empty?
    req = platform_hash[level]
    return req.html_safe if req
  end

  def in_category?(category)
    categories.map(&:name).include?(category)
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
      update_game_data
    else
      # We changed how we stored the data hash, we need to make sure that
      # the row has properly been converted
      ensure_correct_data_hash
      copy_data
    end
    create_relations
    save
  end

  def appid
    steam_appid.to_s
  end

  private

  def ensure_correct_data_hash
    self.data = data[appid]['data'] if data.keys[0] == appid
  end

  # Create a URI object for the steam api endpoint
  def api_uri
    url = "http://store.steampowered.com/api/appdetails/?appids=#{appid}"
    URI.parse(url)
  end

  # Get the latest data from the steam API and parse it into JSON
  def request_fresh_game_data
    response = Net::HTTP.get_response(api_uri)
    return false if response.code == '403'
    JSON.parse(response.body)
  end

  # Update the Game's data with the latest data from the steam API
  def update_game_data
    data = request_fresh_game_data

    if !data || data[appid]['data'].blank?
      errors.add(:Game, 'does not exist')
      return false
    end

    handle_data(data)
  end

  def handle_data(data)
    self.data = data[appid]['data']

    copy_data # datA
    copy_date # datE
  end

  # Copy data out of the data parcel returned
  # by the Steam API into the Game model's fields
  def copy_data
    assign_attributes(
      title: data['name'],
      dlc: data['dlc'],
      header_image: data['header_image'],
      website: data['website'],
      background_image: data['background_image'],
      detailed_description: data['detailed_description'])
  end

  def copy_date
    date_string = data['release_date']['date']
    return if date_string.blank?

    # Steam can return one of three formats for a games date (Yeah, I know, wtf)
    # We have to try and parse the date.
    date_obj = false
    ['%d %b, %Y', '%b %d, %Y', '%b %Y'].each do |format|
      date_obj = Date.strptime(date_string, format) rescue nil
      break if date_obj
    end

    self.release_date = date_obj if date_obj
    puts "Date format unknown: #{date_string}" unless date_obj
  end

  def create_relations
    copy_genres
    copy_categories
    copy_publishers
    copy_developers
    copy_platforms
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
      description = category_hash['description']
      category_model = Category.find_or_create_by(name: description)
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

end
