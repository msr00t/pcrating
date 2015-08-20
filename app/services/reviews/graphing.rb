module Reviews
  class Graphing

    def self.scores
      Game.all.map(&:cached_score).inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }.sort.to_h.to_a
    end

    def self.ranks
      ranks = Game.all.map(&:cached_rank).inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }

      sorted_array = []
      %w(unranked p c m r g).each do |rank|
        sorted_array.append [rank, ranks[rank]]
      end
      sorted_array
    end

    def self.pretty_html_ranks
      self.ranks.inject("") { |string, array| string + "#{array[0].titlecase}: #{array[1]} " }.html_safe
    end

    def self.users
      self.get_grouped_counts(User)
    end

    def self.reviews
      self.get_grouped_counts(Game)
    end

    def self.games
      self.get_grouped_counts(Review)
    end

    private

      def self.get_grouped_counts(model)
        result = model.group_by_day(:created_at, format: "%B %m %Y").count.flatten
        return [] unless result[0]
        result = [result] unless result[0].class == Array
        result.to_s
      end

  end
end