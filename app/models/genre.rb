class Genre < ActiveRecord::Base

  has_many :genre_games, dependent: :destroy
  has_many :games, through: :genre_games

end
