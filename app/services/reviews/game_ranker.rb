module Reviews
  # Takes in a game and produces its rank, stat strings, and
  # a hash of all its stats.
  class GameRanker

    attr_reader :score
    attr_reader :opinion_score

    def initialize(game)
      @game = game
      @reviews = @game.reviews.visible
      calculate_score
    end

    def rank
      Reviews::Ranker.rank(@score)
    end

    def stat_string(stat)
      Reviews::Stats.stat_string(stat, stat_rank(stat))
    end

    def stat_hash
      stats = {}
      STATS.each do |key, values|
        next if values[:section] == :Multiplayer &&
                !@game.in_category?('Multi-player')

        stat_string = Reviews::Stats.stat_string(key, stat_rank(key))
        next unless stat_string
        stats[key] = stat_string
      end
      stats
    end

    private

    def stat_rank(stat)
      average_stat_array @reviews.map { |review| review[stat] }
    end

    def calculate_score
      total = 0
      total_with_opinions = 0
      total_opinion = 0
      return false unless @reviews.size > 0

      @reviews.each do |review|
        total += Reviews::ReviewRanker.new(review).score
        if review.opinion
          total_with_opinions += 1
          total_opinion += review.opinion.to_i
        end
      end

      @score = total / @reviews.size
      @opinion_score = total_opinion / total_with_opinions if total_with_opinions > 0
    end

    def average_stat_array(array)
      array -= [nil]
      array.inject { |a, e| a + e }.to_f / array.size
    end

  end
end
