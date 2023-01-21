class CreateBottleDepositDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :bottle_deposit_details do |t|
    	t.integer :no_of_bottle
    	t.references :recycle_bottle
    	t.timestamps
    end
  end
end
