class CreateTermAndConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :term_and_conditions do |t|
      t.string :description
    end
    add_column :accounts, :term_and_conditions, :boolean, default: :false
    add_column :accounts, :district, :string
  end
end
