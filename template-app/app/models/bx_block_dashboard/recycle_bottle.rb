module BxBlockDashboard
  class RecycleBottle < ApplicationRecord
    self.table_name = :recycle_bottles
    belongs_to :account, class_name: 'AccountBlock::Account'
    before_save :update_co2_emiisions_and_tree_planted

    private

    def update_co2_emiisions_and_tree_planted
      one_bottle_emissions = 1.50/100
      self.CO2_emissions = self.CO2_emissions + one_bottle_emissions*self.no_of_new_bottles
      one_bottle_tree_planted = 0.017/100
      self.trees_planted = self.trees_planted + one_bottle_tree_planted*self.no_of_new_bottles
      self.no_of_bottles = self.no_of_new_bottles + self.no_of_bottles
    end
  end
end
