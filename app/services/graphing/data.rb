module Graphing
  # Calculates and produces data used in various graphs around the site.
  # The data is suited for use in Highcharts via the Chartkick gem
  class Data

    def self.scores
      game_scores = Game.all.map(&:cached_score) - [nil]
      game_scores.each_with_object(Hash.new(0)) do |score, hash|
        hash[score] += 1
      end.sort
    end

    def self.ranks
      ranks = Game.all.map(&:cached_rank)
      counted_ranks = ranks.each_with_object(Hash.new(0)) do |rank, hash|
        hash[rank] += 1
      end

      sorted_array = []
      %w(unranked p c m r g).each do |rank|
        sorted_array.append [rank, counted_ranks[rank] || 0]
      end
      sorted_array
    end

    def self.users
      get_grouped_counts(User)
    end

    def self.reviews
      get_grouped_counts(Review)
    end

    def self.games
      get_grouped_counts(Game)
    end

    # TODO: Refactor this
    def self.get_grouped_counts(model)
      # Go through all records for the given model and group them by the day
      # they were created. Turn that hash of day => count into an array of
      # [day, count]
      grouped_by_day = model.group_by_day(:created_at).count.to_a

      # Here are are creating the array that looks like this:
      # [[day - n, count_up_to_n] ... [day, count_up_to_day]]
      # or in a real example:
      # [['3rd august', 1], ['4th august', 4], ['5th august', 5]]
      # where the total users on the 5th is 5.
      # To do that we are using inject on the 2d array created above.
      # Each time around the loop we create a new row for result_array that
      # consists of a date, along with the last inserted row's total + the
      # total for the date we're currently working on.
      grouped_by_day.inject([['', 0]]) do |result_array, day_count|
        date = day_count[0]
        total_on_date = day_count[1]

        new_row = [date, result_array.last[1] + total_on_date]
        result_array << new_row
      end[1..-1].to_h
    end

  end
end
