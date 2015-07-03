class Game < ActiveRecord::Base
  extend FriendlyId

  require 'net/http'

  serialize :data

  has_many :ratings
  has_many :users, through: :ratings

  belongs_to :user

  validates :steam_appid, uniqueness: true, presence: true

  before_create :request_game_data
  friendly_id :title, use: :slugged

  ##########
  # Rating #
  ##########

  def rating
    ratings_array = ratings.visible

    return false if ratings_array.size == 0

    total = 0

    ratings_array.each do |rating|
      total += rating.total
    end

    total / ratings_array.size
  end

  def ranking
    Rating.ranking(rating)
  end

  def get_stat_string(stat)
    value = get_stat stat

    return 'N/A' unless value

    Rating.send(stat.to_s.pluralize.to_sym).to_a[value][0]
  end

  def get_stat(stat)
    return false if ratings.visible.size <= 0
    ratings.visible.map { |rating| rating[stat] }.average
  end

  def get_rounded_stat(stat)
    stat = get_stat(stat)
    return stat.round if stat
    false
  end

  #############
  # Relations #
  #############

  def rated_by_user?(user)
    rating = Rating.find_by(user: user, game_id: id)

    return true if rating
    false
  end

  #############
  # Game Data #
  #############

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

  private

  def request_game_data
    url = "http://store.steampowered.com/api/appdetails/?appids=#{steam_appid}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)

    copy_data(data) if steam_request_valid?(resp, data)
  end

  def steam_request_valid?(resp, data)
    if data[data.keys[0]]['data'].blank? || resp.code == '403'
      errors.add :Game, 'does not exist'
      return false
    end
    true
  end

  # Copy data out of the data parcel returned
  # by the Steam API into the Game model's fields
  def copy_data(data)
    self.data = data
    self.title = data[data.keys[0]]['data']['name']
  end

end
