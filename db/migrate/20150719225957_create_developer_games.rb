class CreateDeveloperGames < ActiveRecord::Migration
  def change
    create_table :developer_games do |t|
      t.integer :game_id
      t.integer :developer_id

      t.timestamps null: false
    end
  end
end
