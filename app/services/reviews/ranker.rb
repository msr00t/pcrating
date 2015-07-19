module Reviews
  class Ranker

    def initialize(score)
      @score = score
    end

    def rank
      return :unranked unless @score

      case @score
      when 10..19
        :r
      when 0..9
        :m
      when -10..-1
        :c
      else
        if @score >= 20
          :g
        else
          :p
        end
      end
    end

  end
end