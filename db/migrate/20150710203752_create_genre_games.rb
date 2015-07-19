class CreateGenreGames < ActiveRecord::Migration
  def change
    create_table :genre_games do |t|
      t.integer :genre_id
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
