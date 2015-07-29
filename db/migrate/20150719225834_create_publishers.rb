class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :slug, unique: true

      t.timestamps null: false
    end

    add_index :developers, :slug, unique: true
  end
end
