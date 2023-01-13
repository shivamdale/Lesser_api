ActiveAdmin.register AccountBlock::Account, as:"User" do

  permit_params :first_name, :last_name, :email, :full_phone_number, :country_code, :phone_number, :activated, :password, :password_confirmation, :image

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :country_code
    column :phone_number
    column :activated
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone_number
      row :activated
      row :created_at
      row :updated_at
      row :image do |a|
        image_tag url_for(a.image), size: '100x100' if a.image.present?
      end
    end
  end

  filter :first_name

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :full_phone_number
      f.input :activated, as: :select, collection:  %w[true false]
      f.input :password
      f.input :password_confirmation
      f.input :image, :as => :file
    end
    f.actions
  end
end