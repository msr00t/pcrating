class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged

  acts_as_voter
  audited only: [:banned, :admin]

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :filed_reports, class_name: 'Report', dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :games, through: :reviews
  has_many :added_games, class_name: 'Game'
  has_many :bans, as: :banner, class_name: 'User'
  has_many :deleted_reviews, as: :deleter, class_name: 'Review'

  belongs_to :banner, class_name: 'User'

  validates :username, presence: true, uniqueness: true

  enum admin: {
    user: 0,
    mod: 1,
    admin: 2
  }

  def ban!(banner)
    return unless banner.admin > self.admin
    self.admin = 0
    self.banned = true
    self.banner = banner

    if save
      reviews.destroy_all
      reports.accept!
    end
  end

  def moderator?
    mod? || admin?
  end

  def reported_by?(user)
    reports.find_by(user: user, status: 0)
  end

  def report!(user)
    reports.create(user: user) unless user == self
  end

  def has_deleted_review?(game)
    Review.only_deleted.find_by(user: self, game: game) != nil
  end

  def score
    reviews.sum(:cached_votes_score) - reviews.size
  end

  def convert_ratings_into_reviews
    converter = Reviews::Converter.new(self)
    converter.convert_ratings_into_reviews
  end

end
