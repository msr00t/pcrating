class Publisher < ActiveRecord::Base

  has_many :publisher_games, dependent: :destroy
  has_many :games, through: :publisher_games

end
