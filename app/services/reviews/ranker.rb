module Reviews
  class Ranker

    def initialize(score)
      @score = score
    end

    def rank
      return :unranked unless @score

      case @score
      when -20..-11
        :r
      when -30..-21
        :m
      when -40..-31
        :c
      else
        if @score >= -10
          :g
        else
          :p
        end
      end
    end

  end
end