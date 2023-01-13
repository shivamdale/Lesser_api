ActiveAdmin.register BxBlockRolesPermissions::AdminRole,as: 'Admin Role' do
  permit_params :name, permitted_modules: {}
  menu parent: "Roles And Permission" , label: "Admin Role"

  config.batch_actions = false
  index do
    selectable_column
    id_column
    column :name
    actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end

  filter :name
  form do |f|
    f.inputs do
    f.input :name
    end
    f.actions
  end
end

