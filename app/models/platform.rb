class Platform < ActiveRecord::Base

  has_many :platform_games, dependent: :destroy
  has_many :games, through: :platform_games

end
