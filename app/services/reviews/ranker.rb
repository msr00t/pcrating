module Reviews
  class Ranker

    def initialize(score)
      @score = score
    end

    def rank
      return :unranked unless @score

      case @score
      when 4..10
        :r
      when -5..3
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