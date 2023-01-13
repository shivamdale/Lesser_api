module AdminUsers
  class Load
    @@loaded_from_gem = false
    def self.is_loaded_from_gem
      @@loaded_from_gem
    end

    def self.loaded
    end

    # Check if this file is loaded from gem directory or not
    # The gem directory looks like
    # /template-app/.gems/gems/bx_block_custom_user_subs-0.0.7/app/admin/subscription.rb
    # if it has block's name in it then it's a gem
    @@loaded_from_gem = Load.method('loaded').source_location.first.include?('bx_block_')
  end
end

unless AdminUsers::Load.is_loaded_from_gem
  ActiveAdmin.register AdminUser, as: "Admin Accounts" do
    permit_params :email, :password, :password_confirmation, :admin_role_id, :image

    index do
      selectable_column
      id_column
      column :email
      column :admin_role
      column "Create Date", :created_at 
      actions
    end

    filter :email
    filter :created_at, label: "Create Date"

    form do |f|
      f.inputs do
        f.input :email
        f.input :password
        f.input :password_confirmation, :required => true
        f.input :admin_role_id, label: "Role", as: :select, collection: BxBlockRolesPermissions::AdminRole.all.map{|a| [a.name, a.id] }
        f.input :image, :as => :file
      end
      f.actions do
      if resource.persisted?
        f.action :submit, label: 'Update', class: 'action input_action'
      else
        f.action :submit, label: 'Create User ', class: 'action input_action'
      end
      f.action :cancel, as: :link, label: 'Cancel'
      end
    end

    show do
      attributes_table do
        row :email
        row :image do |a|
          image_tag url_for(a.image), size: '100x100' if a.image.present?
        end
      end
    end
  end
end
