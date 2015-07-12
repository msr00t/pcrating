class User < ActiveRecord::Base
  acts_as_voter

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :ratings, dependent: :destroy
  has_many :games, through: :ratings
  has_many :added_games, class_name: 'Game'

  validates :username, presence: true, uniqueness: true

  def score
    ratings.sum(:cached_votes_score) - ratings.size
  end

end
