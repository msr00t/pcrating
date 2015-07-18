class Review < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  belongs_to :game

  RANKS.each do |stat, values|
    enum stat => values
  end

  def self.visible
    all.select do |rating|
      !rating.hidden?
    end
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

end
