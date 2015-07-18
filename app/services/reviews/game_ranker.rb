module Reviews
  class GameRanker

    def initialize(game)
      @game = game
      @reviews = @game.reviews.visible
      @score = calculate_score
    end

    def rank
      Reviews::Ranker.new(@score).rank
    end

    def score
      @score
    end

    def stat_hash
      stats = {}
      STATS.each do |key, values|
        stat_name = Reviews::Stats.display_name(key)
        stat_string = stat_string(key)
        next unless stat_string
        stats[stat_name] = stat_string
      end
      stats
    end

    def stat_rank(stat)
      average_stat_array @reviews.map { |review| review[stat] }
    end

    def stat_score(stat)
      stat_info(stat, 1)
    end

    def stat_string(stat)
      stat_info(stat, 0)
    end

    private

    def calculate_score
      total = 0
      return false unless @reviews.size > 0

      @reviews.each do |review|
        total += Reviews::ReviewRanker.new(review).score
      end

      total / @reviews.size
    end

    def stat_info(stat, id)
      stat_rank = stat_rank(stat)
      return false if stat_rank.nan?
      STATS[stat][:ranks].to_a[stat_rank][id]
    end

    def average_stat_array(array)
      array = array - [nil]
      array.inject { |a, e| a + e }.to_f / array.size
    end

  end
end