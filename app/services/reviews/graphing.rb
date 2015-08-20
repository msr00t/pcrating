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

      # TODO: Refactor this
      def self.get_grouped_counts(model)
        # Go through all records for the given model and group them by the day they were created
        # Turn that hash of day => count into an array of [day, count]
        grouped_by_day = model.group_by_day(:created_at, format: '%d %m %y').count.to_a

        # Here are are creating the array that looks like this
        # [[day - n, total_count_up_to_n], [day - (n+1), total_count_up_to_n+1] ... [day, total_count_up_to_day]]
        # or in a real example [['3rd august', 1], ['4th august', 4], ['5th august', 5]], where the total users on
        # the 5th is 5.
        # To do that we are using inject on the 2d array created above.
        # Each time around the loop we create a new row for result_array that consists of a date, along with
        # the last inserted row's total + the total for the date we're currently working on.
        grouped_by_day.inject([['Start', 0]]) do |result_array, day_count|
          date = day_count[0]
          total_on_date = day_count[1]

          new_row = [date, result_array.last[1] + total_on_date]
          result_array << new_row
        end
      end

  end
end