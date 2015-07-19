class Developer < ActiveRecord::Base

  has_many :developer_games, dependent: :destroy
  has_many :games, through: :developer_games

end
