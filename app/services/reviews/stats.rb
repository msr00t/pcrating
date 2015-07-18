module Reviews
  class Stats

    def self.stat_names
      STATS.keys
    end

    def self.enum(stat)
      enum = {}
      ranks = STATS[stat][:ranks]

      ranks.each_with_index do |key, index|
        enum[key[0]] = index
      end

      return enum
    end

    def self.display_name(stat)
      STATS[stat][:display_name].to_s
    end

  end
end