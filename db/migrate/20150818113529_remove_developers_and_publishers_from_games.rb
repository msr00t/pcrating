class RemoveDevelopersAndPublishersFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :developers, :string
    remove_column :games, :publishers, :string
  end
end
