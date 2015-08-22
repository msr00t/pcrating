class CreateCategoryGames < ActiveRecord::Migration
  def change
    create_table :category_games do |t|
      t.integer :game_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
