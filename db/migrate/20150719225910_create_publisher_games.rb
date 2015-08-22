class CreatePublisherGames < ActiveRecord::Migration
  def change
    create_table :publisher_games do |t|
      t.integer :game_id
      t.integer :publisher_id

      t.timestamps null: false
    end
  end
end
