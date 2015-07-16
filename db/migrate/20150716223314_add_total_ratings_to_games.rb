class AddTotalRatingsToGames < ActiveRecord::Migration
  def up
    add_column :games, :total_ratings, :integer

    Game.find_each(&:save)
  end

  def down
    remove_column :games, :total_ratings
  end
end
