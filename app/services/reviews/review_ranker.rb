module Reviews
  # Takes in a review and can produce its score, rank
  # and a hash of it's stats
  class ReviewRanker

    attr_reader :score

    def initialize(review)
      @review = review
      @game = @review.game
      @score = numerical_score
    end

    def calculate_score!
      @review.cached_score = score
      @review.cached_rank = rank
      @review.save
    end

    def rank
      Reviews::Ranker.rank(@score)
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
      @review[stat]
    end

    def numerical_score
      total = 0

      STATS.each do |key, values|
        next if values[:section] == :Multiplayer &&
                !@game.in_category?('Multi-player')

        score_key = @review.send(key)
        total += STATS[key][:ranks][score_key.to_sym] if score_key
      end

      total
    end

  end
end
