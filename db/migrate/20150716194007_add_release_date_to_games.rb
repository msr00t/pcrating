class AddReleaseDateToGames < ActiveRecord::Migration
  def change
    add_column :games, :release_date, :datetime

    Game.all.each do |game|
      game.copy_data
      game.save
    end
  end
end
