class Review < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  belongs_to :game

  has_many :reports, dependent: :destroy

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

  def report(user)
    reports.create(user: user) unless user == self.user
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
