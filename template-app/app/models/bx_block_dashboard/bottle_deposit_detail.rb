module BxBlockDashboard
  class BottleDepositDetail < ApplicationRecord
    self.table_name = :bottle_deposit_details
    belongs_to :recycle_bottle, class_name: 'BxBlockDashboard::RecycleBottle'
  end
end
