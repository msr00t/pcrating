class AddBannerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :banner_id, :integer
  end
end
