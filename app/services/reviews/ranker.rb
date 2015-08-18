module Reviews
  class Ranker

    def initialize(score)
      @score = score
    end

    def rank
      return :unranked unless @score

      case @score
      when 1..10
        :r
      when -5..0
        :m
      when -15..-6
        :c
      else
        if @score >= 11
          :g
        else
          :p
        end
      end
    end

  end
end