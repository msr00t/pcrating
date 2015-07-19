class AddColumnsToGames < ActiveRecord::Migration
  def up
    add_column :games, :dlc,                  :string
    add_column :games, :detailed_description, :string
    add_column :games, :platforms,            :string
    add_column :games, :developers,           :string
    add_column :games, :publishers,           :string
    add_column :games, :header_image,         :string
    add_column :games, :website,              :string
    add_column :games, :background_image,     :string
  end

  def down
    remove_column :games, :platforms
    remove_column :games, :developers
    remove_column :games, :publishers
    remove_column :games, :header_image
    remove_column :games, :website
    remove_column :games, :background_image
  end
end
