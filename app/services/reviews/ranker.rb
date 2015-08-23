module Reviews
  # Produces a Rank from a given score
  class Ranker

    def self.rank(score)
      return :unranked unless score
      return :g if score >= 11

      { r: 4..10,
        m: -5..3,
        c: -15..-6 }.each { |k, v| return k if v.to_a.include? score }
      :p
    end

  end
end
