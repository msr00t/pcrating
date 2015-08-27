class AddGmgUrlToGames < ActiveRecord::Migration
  def change
    add_column :games, :gmg_url, :string

    Game.find_each(&:save)
  end
end
