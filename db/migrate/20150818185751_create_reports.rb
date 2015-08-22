class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :reportable_id
      t.string  :reportable_type
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
