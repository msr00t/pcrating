module Reviews
  # Used for requesting various pieces of data
  # related to stats, including scores and strings.
  # Also produces the enums used in the User model.
  class Stats

    def self.stat_names
      STATS.keys
    end

    def self.by_group
      STATS.group_by { |_key, value| value[:section] }
    end

    def self.enum(stat)
      enum = {}
      ranks = STATS[stat][:ranks]

      ranks.each_with_index do |key, index|
        enum[key[0]] = index
      end

      enum
    end

    def self.display_name(stat)
      STATS[stat][:display_name].to_s
    end

    def self.stat_score(stat, rank)
      stat_info(stat, 1, rank)
    end

    def self.stat_string(stat, rank)
      stat_info(stat, 0, rank)
    end

    def self.stat_info(stat, id, rank)
      return false if rank.class == Float && rank.nan? || rank.nil?
      STATS[stat][:ranks].to_a[rank][id]
    end

  end
end
