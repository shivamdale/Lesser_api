class CreateAdminRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_roles do |t|
      t.string :name
      t.jsonb :permitted_modules, default: {}
      t.timestamps
    end
  end
end
