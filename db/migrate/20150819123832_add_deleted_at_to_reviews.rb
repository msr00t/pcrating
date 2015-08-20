class AddDeletedAtToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :deleted_at, :datetime
  end
end
