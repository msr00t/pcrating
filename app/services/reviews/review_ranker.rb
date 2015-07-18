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

    private

      def numerical_score
        total = 0

        RANKS.each do |key, values|
          score_key = @review.send(key)
          total += SCORES[key][score_key.to_sym] if score_key
        end

        return total
      end

  end
end