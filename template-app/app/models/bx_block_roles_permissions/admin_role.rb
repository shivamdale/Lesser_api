module BxBlockRolesPermissions
  class AdminRole < ApplicationRecord
    self.table_name = :admin_roles
    has_many :admin_users, class_name: 'AdminUser', foreign_key: "admin_role_id", dependent: :destroy
    validates :name, :presence => true
    validates :name, uniqueness: { message: 'Role already present' }
  end
end


