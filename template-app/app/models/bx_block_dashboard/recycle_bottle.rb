module BxBlockDashboard
  class RecycleBottle < ApplicationRecord
    self.table_name = :recycle_bottles
    belongs_to :account, class_name: 'AccountBlock::Account'
    has_many :bottle_deposit_details, class_name: 'BxBlockDashboard::BottleDepositDetail'
    before_save :update_co2_emiisions_and_tree_planted
    after_create :create_bottle_deposit_details

    private

    def update_co2_emiisions_and_tree_planted
      one_bottle_emissions = 1.50/100
      self.CO2_emissions = self.CO2_emissions + one_bottle_emissions*self.no_of_new_bottles
      one_bottle_tree_planted = 0.017/100
      self.trees_planted = self.trees_planted + one_bottle_tree_planted*self.no_of_new_bottles
      self.no_of_bottles = self.no_of_new_bottles + self.no_of_bottles
      rewards = self.rewards
      BxBlockLevel::Level.all.each do |level|
        if rewards >= level.min_rewards && rewards <= level.max_rewards
          unless self.account.levels.pluck(:name).include?(level.name)
            self.account.account_levels.create(level_id: level.id, present_level: true)
          end
          self.level = level.name
        end
      end
    end

    def create_bottle_deposit_details
      self.bottle_deposit_details.create(no_of_bottle: self.no_of_new_bottles)
    end
  end
end
