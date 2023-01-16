ActiveAdmin.register AccountBlock::City,as: 'City' do
    menu parent: "User Profile", label: "City"
    permit_params :title
  
    index do
      selectable_column
      id_column
      column :title
      actions
    end
  
    show do
      attributes_table do
        row :title
        row :created_at
        row :updated_at
      end
    end
  
    filter :role
  
    form do |f|
      f.inputs do
        f.input :title
      end
      f.actions
    end
  end