class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :name
      t.string :slug, unique: true

      t.timestamps null: false
    end

    add_index :developers, :slug, unique: true
  end
end
