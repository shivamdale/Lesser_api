class AddRoleIdToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :admin_role_id, :integer
  end
end
