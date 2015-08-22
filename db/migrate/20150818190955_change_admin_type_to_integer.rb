class ChangeAdminTypeToInteger < ActiveRecord::Migration
  def change
    change_column :users, :admin, 'integer USING CAST(admin AS integer)', default: 0
  end
end
