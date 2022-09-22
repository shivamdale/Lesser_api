# This migration comes from bx_block_qr_codes (originally 20210211050258)
class CreateQrCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :qr_codes do |t|
      t.references :qrable, polymorphic: true

      t.timestamps
    end
  end
end
