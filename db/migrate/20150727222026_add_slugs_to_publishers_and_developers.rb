class AddSlugsToPublishersAndDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :slug, :string, unique: true
    add_index :developers, :slug, unique: true
    add_column :publishers, :slug, :string, unique: true
    add_index :publishers, :slug, unique: true

    Publisher.find_each(&:save)
    Developer.find_each(&:save)
  end
end
