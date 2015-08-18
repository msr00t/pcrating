class UpdateTables < ActiveRecord::Migration
  def up
    Game.all.each do |game|
      game.created_at = Time.now
      game.updated_at = Time.now
      game.force_update!
    end

    User.find_each(&:convert_ratings_into_reviews)
    Game.recalculate_scores
  end
end
