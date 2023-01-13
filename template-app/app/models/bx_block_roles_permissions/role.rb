module BxBlockRolesPermissions
  class Role < ApplicationRecord
    self.table_name = :roles
    has_many :accounts, class_name: 'AccountBlock::Account', dependent: :destroy
    has_many :admin_users, class_name:  "AdminUser"
    validates :name, uniqueness: { message: 'Role already present' }
  end
end
