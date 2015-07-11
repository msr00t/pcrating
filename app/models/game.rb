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
  friendly_id :title, use: :slugged

  scope :top, -> { order(cached_rating: :desc) }
  scope :bottom, -> { order(created_at: :asc) }
  scope :latest, -> { order(created_at: :desc) }
  scope :rated, -> { where('id IN (SELECT DISTINCT(game_id) FROM ratings)') }

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

    copy_data data
  end

  # Copy data out of the data parcel returned
  # by the Steam API into the Game model's fields
  def copy_data(data)
    self.data = data
    self.title = data[steam_appid.to_s]['data']['name']
    copy_genres
  end

  def copy_genres
    genres = data[steam_appid.to_s]['data']['genres']
    genres.each do |genre_hash|
      genre_model = Genre.find_or_create_by(name: genre_hash['description'])

      GenreGame.new(game: self, genre: genre_model)
    end
  end

end
