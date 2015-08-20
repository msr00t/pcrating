class Review < ActiveRecord::Base
  acts_as_votable
  acts_as_paranoid
  audited on: [:destroy]

  belongs_to :user
  belongs_to :game

  belongs_to :deleter, class_name: 'User'

  has_many :reports, as: :reportable, dependent: :destroy

  validates_uniqueness_of :user_id, :scope => [:game_id]

  after_save :update_game

  default_scope { order(cached_votes_score: :desc) }

  STATS.each do |stat, values|
    enum stat => Reviews::Stats.enum(stat)
    unless values[:section] == :'Multiplayer'
      validates stat, presence: true
    end
  end

  def self.visible
    all.select do |review|
      !review.hidden?
    end
  end

  def report!(user)
    reports.create(user: user) unless user == self.user
  end

  def reported_by?(user)
    reports.find_by(user: user, status: 0)
  end

  def restore!
    self.deleter = nil
    self.deleted_at = nil
    self.save
  end

  def delete!(user)
    self.deleter = user
    self.save
    self.destroy
  end

  def hidden?
    score < -3
  end

  def score
    cached_votes_score
  end

  def rank
    Reviews::ReviewRanker.new(self).rank
  end

  def stats
    Reviews::ReviewRanker.new(self).stat_hash
  end

  private

    def update_game
      game.update_cached_data
      game.save
    end

end
