module Reviews
  class GameRanker

    def initialize(game)
      @game = game
      @score = numerical_score
      @reviews = @game.reviews.visible
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

      total / @game.reviews.size
    end

  end
end