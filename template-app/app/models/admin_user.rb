class AdminUser < ApplicationRecord
  devise :database_authenticatable,
          :recoverable, :rememberable, :validatable
  has_one_attached :image, dependent: :destroy
  belongs_to :admin_role, class_name: "BxBlockRolesPermissions::AdminRole", foreign_key: "admin_role_id"
end
