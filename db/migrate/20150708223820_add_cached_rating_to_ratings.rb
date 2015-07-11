class AddCachedRatingToRatings < ActiveRecord::Migration
  def change
    add_column :games, :cached_rating, :integer

    Game.all.each do |game|
      game.calculate_rating!
    end
  end
end
