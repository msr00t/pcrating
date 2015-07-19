class UpdateTables < ActiveRecord::Migration
  def up
    Game.all.each do |game|
      game.force_update
      game.created_at = Time.now
      game.updated_at = Time.now
      game.save
    end

    User.find_each(&:convert_ratings_into_reviews)
    Game.find_each(&:save)
  end
end
