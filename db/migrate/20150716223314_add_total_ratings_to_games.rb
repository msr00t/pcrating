class AddTotalRatingsToGames < ActiveRecord::Migration
  def up
    add_column :games, :total_ratings, :integer
  end

  def down
    remove_column :games, :total_ratings
  end
end
