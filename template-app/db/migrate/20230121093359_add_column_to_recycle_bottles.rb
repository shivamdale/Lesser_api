class AddColumnToRecycleBottles < ActiveRecord::Migration[6.0]
  def change
    add_column :recycle_bottles, :rewards, :float, default: 0
    add_column :recycle_bottles, :level, :string
  end
end
