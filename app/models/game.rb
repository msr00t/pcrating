class Game < ActiveRecord::Base
  extend FriendlyId

  require 'net/http'

  serialize :data

  has_many :ratings, dependent: :destroy
  has_many :users, through: :ratings
  has_many :genre_games, dependent: :destroy
  has_many :genres, through: :genre_games

  belongs_to :user

  validates :steam_appid, uniqueness: true

  before_create :request_game_data
  after_create :copy_genres
  friendly_id :title, use: :slugged

  scope :top, -> { order(cached_rating: :desc) }
  scope :bottom, -> { rated.order(cached_rating: :asc) }
  scope :latest, -> { order(release_date: :desc) }
  scope :with_release_date, -> { where.not(release_date: nil) }
  scope :rated, -> { where('games.id IN (SELECT DISTINCT(game_id) FROM ratings)') }

  def rating
    cached_rating
  end

  def calculate_rating!
    ratings_array = ratings.visible

    if ratings_array.size == 0
      self.cached_rating = -1
      return save
    end

    total = 0

    ratings_array.each do |rating|
      total += rating.total
    end

    result = total / ratings_array.size

    self.cached_rating = result
    save
  end

  # Stats

  def ranking
    Rating.ranking(rating)
  end

  def stats
    { 'Framerate':    get_stat_string(:framerate),
      'Resolution':   get_stat_string(:resolution),
      'Optimization': get_stat_string(:optimization),
      'Mods':         get_stat_string(:mods),
      'Servers':      get_stat_string(:servers),
      'DLC':          get_stat_string(:dlc),
      'Bugs':         get_stat_string(:bugs),
      'Settings':     get_stat_string(:settings),
      'Controls':     get_stat_string(:controls) }
  end

  def get_stat_string(stat)
    value = get_stat stat

    return 'N/A' if value.nan?

    Rating.send(stat.to_s.pluralize.to_sym).to_a[value][0]
  end

  def get_stat(stat)
    average_array ratings.visible.map { |rating| rating[stat] }
  end

  def get_rounded_stat(stat)
    get_stat(stat).round
  end

  def average_array(array)
    array.inject { |a, e| a + e }.to_f / array.size
  end

  # Static Data

  def description
    desc = data[steam_appid.to_s]['data']['detailed_description'] if data
    return desc.html_safe if desc
  end

  def dlc
    data[steam_appid.to_s]['data']['dlc'] if data
  end

  def requirements(platform, level)
    return false unless data

    platform_hash = data[steam_appid.to_s]['data']["#{platform}_requirements"]
    return false if platform_hash.empty?
    req = platform_hash[level]
    return req.html_safe if req
  end

  def platforms
    data[steam_appid.to_s]['data']['platforms']
  end

  def developers
    data[steam_appid.to_s]['data']['developers'] if data
  end

  def publishers
    data[steam_appid.to_s]['data']['publishers'] if data
  end

  def header_image
    data[steam_appid.to_s]['data']['header_image'] if data
  end

  def website
    data[steam_appid.to_s]['data']['website'] if data
  end

  def background_image
    data[steam_appid.to_s]['data']['background'] if data
  end

  def launch_game_link
    "steam://run/#{steam_appid}"
  end

  def store_link
    "http://store.steampowered.com/app/#{steam_appid}/"
  end

  def rated_by_user?(user)
    return false unless user

    rating = Rating.find_by(user_id: user.id, game_id: id)

    return true if rating
  end

  def request_game_data
    url = "http://store.steampowered.com/api/appdetails/?appids=#{steam_appid}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)

    if data[steam_appid.to_s]['data'].blank? || resp.code == '403'
      errors.add :Game, 'does not exist'
      return false
    end

    self.data = data

    copy_data
  end

  # Copy data out of the data parcel returned
  # by the Steam API into the Game model's fields
  def copy_data
    self.title = data[steam_appid.to_s]['data']['name']
    copy_date
  end

  def copy_date
    date_string = data[steam_appid.to_s]['data']['release_date']['date']

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
    genres = data[steam_appid.to_s]['data']['genres']

    return false unless genres

    genres.each do |genre_hash|
      genre_model = Genre.find_or_create_by(name: genre_hash['description'])

      genre_model.games.push self
    end
  end

end