class CreateAgeGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :age_groups do |t|
      t.string :title
    end
  end
end
