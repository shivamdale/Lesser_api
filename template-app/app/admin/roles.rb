ActiveAdmin.register BxBlockRolesPermissions::Role,as: 'Role' do
  permit_params :name
  menu parent: "Roles And Permission", label: "Role"

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

  filter :role

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end
end