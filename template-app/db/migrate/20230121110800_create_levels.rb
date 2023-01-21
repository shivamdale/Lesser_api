class CreateLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :levels do |t|
    	t.string :name
    	t.float :min_rewards
    	t.float :max_rewards
    	t.timestamps
    end
    create_table :account_levels  do |t|
    	t.references :account
    	t.references :level
        t.boolean :present_level, default: :false
    end
  end
end
