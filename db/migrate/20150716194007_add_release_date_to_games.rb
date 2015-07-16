class AddReleaseDateToGames < ActiveRecord::Migration
  def up
    add_column :games, :release_date, :date

    Game.all.each do |game|
      game.copy_data
      game.save
    end
  end

  def down
    remove_column :games, :release_date
  end
end
