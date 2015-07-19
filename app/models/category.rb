class Category < ActiveRecord::Base

  has_many :category_games, dependent: :destroy
  has_many :games, through: :category_games

end
