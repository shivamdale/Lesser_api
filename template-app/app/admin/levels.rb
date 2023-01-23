ActiveAdmin.register BxBlockLevel::Level,as: 'Level' do
  permit_params :name, :min_rewards, :max_rewards
  
  index do
    selectable_column
    id_column
    column :name
    column :min_rewards
    column :max_rewards
    actions
  end

  show do
    attributes_table do
      row :name
      row :min_rewards
      row :max_rewards
      row :created_at
      row :updated_at
    end
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :min_rewards, label: "Minimum Rewards"
      f.input :max_rewards, label: "Maximum Rewards"
    end
    f.actions
  end
end