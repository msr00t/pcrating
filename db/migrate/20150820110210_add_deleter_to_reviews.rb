class AddDeleterToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :deleter_id, :integer
  end
end
