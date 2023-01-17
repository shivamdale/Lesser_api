class CreateRecycleBottles < ActiveRecord::Migration[6.0]
  def change
    create_table :recycle_bottles do |t|
      t.integer :no_of_bottles, default: 0
      t.integer :no_of_new_bottles, default: 0
      t.integer :account_id
      t.float :CO2_emissions, default: 0
      t.float :trees_planted, default: 0
      t.timestamps
    end
  end
end
