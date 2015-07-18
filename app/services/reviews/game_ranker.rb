module Reviews
  class GameRanker

    def initialize(game)
      @game = game
      @reviews = @game.reviews.visible
      @score = numerical_score
    end

    def calculate_score!
      @game.cached_score = @score
      @game.cached_rank = Reviews::Ranker.new(@score).rank
      @game.save
    end

    def numerical_score
      total = 0

      return false unless @reviews

      @reviews.each do |review|
        total += Reviews::ReviewRanker.new(review).score
      end

      total / @reviews.size
    end

  end
end