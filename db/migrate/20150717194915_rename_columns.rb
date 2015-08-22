class RenameColumns < ActiveRecord::Migration
  def change
    rename_column :games, :cached_rating, :cached_score
    rename_column :games, :total_ratings, :cached_reviews_total
    add_column :games, :cached_rank, :string
  end
end
