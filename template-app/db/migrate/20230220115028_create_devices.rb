class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
    	t.belongs_to :account
    	t.string :device_id
    	t.timestamps
    end
  end
end
