module Reviews
  class Graphing

    def self.scores
      Game.all.map(&:cached_score).inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }.sort.to_h.to_a
    end

    def self.ranks
      ranks = Game.all.map(&:cached_rank).inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
      sorted_array = []
      %w(unranked p c m r g).each do |rank|
        sorted_array.append [rank, ranks[rank]]
      end
      sorted_array
    end

  end
end