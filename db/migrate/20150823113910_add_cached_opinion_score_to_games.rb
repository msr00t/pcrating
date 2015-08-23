class AddCachedOpinionScoreToGames < ActiveRecord::Migration
  def change
    add_column :games, :cached_opinion_score, :float
  end
end
