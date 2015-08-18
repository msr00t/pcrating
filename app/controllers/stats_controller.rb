class StatsController < ApplicationController

  def stats
    @game_scores = Game.all.map(&:cached_score).inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }.sort.to_h.to_a
    @game_ranks = Game.all.map(&:cached_rank).inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }.sort.to_h.to_a
  end

end
