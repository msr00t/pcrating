class CreatePlatformGames < ActiveRecord::Migration
  def change
    create_table :platform_games do |t|
      t.integer :game_id
      t.integer :platform_id

      t.timestamps null: false
    end
  end
end
