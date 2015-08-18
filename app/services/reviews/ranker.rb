module Reviews
  class Ranker

    def initialize(score)
      @score = score
    end

    def rank
      return :unranked unless @score

      case @score
      when 5..14
        :r
      when -5..4
        :m
      when -15..-6
        :c
      else
        if @score >= 15
          :g
        else
          :p
        end
      end
    end

  end
end