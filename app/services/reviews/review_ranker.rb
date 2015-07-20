module Reviews
  class ReviewRanker

    def initialize(review)
      @review = review
      @score = numerical_score
    end

    def calculate_score!
      @review.cached_score = score
      @review.cached_rank = rank
      @review.save
    end

    def score
      @score
    end

    def rank
      Reviews::Ranker.new(@score).rank
    end

    def stat_hash
      stats = {}
      STATS.each do |key, values|
        stat_name = key
        stat_rank = stat_rank(key)
        stat_string = Reviews::Stats.stat_string(key, stat_rank)
        next unless stat_string
        stats[stat_name] = stat_string
      end
      stats
    end

    private

      def stat_rank(stat)
        @review[stat]
      end

      def numerical_score
        total = 0

        STATS.each do |key, values|
          score_key = @review.send(key)
          total += STATS[key][:ranks][score_key.to_sym] if score_key
        end

        return total
      end

  end
end