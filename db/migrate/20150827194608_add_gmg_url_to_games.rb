class AddGmgUrlToGames < ActiveRecord::Migration
  def change
    add_column :games, :gmg_url, :string
  end
end
