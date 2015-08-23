# The user class, represents a person using the site
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

  has_many :reviews, dependent: :destroy
  has_many :filed_reports, class_name: 'Report', dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :games, through: :reviews
  has_many :added_games, class_name: 'Game'
  has_many :bans, as: :banner, class_name: 'User'
  has_many :deleted_reviews, as: :deleter, class_name: 'Review'

  belongs_to :banner, class_name: 'User'

  validates :username, presence: true, uniqueness: true

  after_create :send_email_to_sendgrid
  after_update :update_email_on_sendgrid
  after_destroy :remove_email_from_sendgrid

  enum admin: {
    user: 0,
    mod: 1,
    admin: 2
  }

  def ban!(banner)
    return unless banner.admin > admin
    self.admin = 0
    self.banned = true
    self.banner = banner

    return unless save

    reviews.destroy_all
    reports.accept!
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

  def deleted_review?(game)
    Review.only_deleted.find_by(user: self, game: game) != nil
  end

  def score
    reviews.sum(:cached_votes_score) - reviews.size
  end

  private

  def send_email_to_sendgrid
    Sendgrid::Emails.create(
      'email' => email,
      'name' =>  username)
  end

  def update_email_on_sendgrid
    return unless changes['email']
    Sendgrid::Emails.update(
      'old_email' => changes['email'][0],
      'email' =>     changes['email'][1],
      'name' =>      username)
  end

  def remove_email_from_sendgrid
    Sendgrid::Emails.destroy('email' => email)
  end

end
