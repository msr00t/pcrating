module Reviews
  class Ranker

    def initialize(score)
      @score = score
    end

    def rank
      return :unranked unless @score

      case @score
      when 0..9
        :r
      when -10..-1
        :m
      when -19..-9
        :c
      else
        if @score >= 10
          :g
        else
          :p
        end
      end
    end

  end
end