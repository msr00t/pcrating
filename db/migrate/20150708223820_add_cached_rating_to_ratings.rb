class AddCachedRatingToRatings < ActiveRecord::Migration
  def change
    add_column :games, :cached_rating, :integer
  end
end
