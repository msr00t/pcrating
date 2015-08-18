class ChangeAdminTypeToInteger < ActiveRecord::Migration
  def up
    change_column :users, :admin, 'integer USING CAST(admin AS integer)', default: 0
  end

  def down
    change_column :users, :admin, 'boolean USING CAST(admin AS boolean)'
  end
end
