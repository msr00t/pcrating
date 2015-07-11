class Game < ActiveRecord::Base
  extend FriendlyId

  require 'net/http'

  serialize :data

  has_many :ratings
  has_many :users, through: :ratings
  has_many :genre_games
  has_many :genres, through: :genre_games

  belongs_to :user

  validates :steam_appid, uniqueness: true

  before_create :request_game_data
  friendly_id :title, use: :slugged

  scope :top, -> { order(cached_rating: :desc) }
  scope :bottom, -> { order(created_at: :asc) }
  scope :latest, -> { order(created_at: :desc) }

  def rating
    cached_rating
  end

  def calculate_rating!
    ratings_array = ratings.visible

    return false if ratings_array.size == 0

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
    desc = data[data.keys[0]]['data']['detailed_description'] if data
    return desc.html_safe if desc
  end

  def dlc
    data[data.keys[0]]['data']['dlc'] if data
  end

  def min_requirements
    req = data[data.keys[0]]['data']['pc_requirements']['minimum'] if data
    return req.html_safe if req
  end

  def recommended_requirements
    req = data[data.keys[0]]['data']['pc_requirements']['recommended'] if data
    return req.html_safe if req
  end

  def developers
    data[data.keys[0]]['data']['developers'] if data
  end

  def publishers
    data[data.keys[0]]['data']['publishers'] if data
  end

  def header_image
    data[data.keys[0]]['data']['header_image'] if data
  end

  def website
    data[data.keys[0]]['data']['website'] if data
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

    if data[data.keys[0]]['data'].blank? || resp.code == '403'
      errors.add :Game, 'does not exist'
      return false
    end

    copy_data data
  end

  # Copy data out of the data parcel returned
  # by the Steam API into the Game model's fields
  def copy_data(data)
    self.data = data
    self.title = data[data.keys[0]]['data']['name']
    copy_genres
  end

  def copy_genres
    genres = data[steam_appid.to_s]['data']['genres']
    genres.each do |genre_hash|
      genre_model = Genre.find_or_create_by(name: genre_hash['description'])

      g = GenreGame.new(game: self, genre: genre_model)
    end
  end

end
