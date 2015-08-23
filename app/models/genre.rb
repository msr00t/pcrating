# Game Genres.
class Genre < ActiveRecord::Base

  RANSACKABLE_ATTRIBUTES = %w(name)

  has_many :genre_games, dependent: :destroy
  has_many :games, through: :genre_games

  def self.ransackable_attributes(auth_object = nil)
    return super if auth_object == :admin
    super & RANSACKABLE_ATTRIBUTES
  end

end
