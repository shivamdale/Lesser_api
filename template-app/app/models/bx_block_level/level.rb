module BxBlockLevel
	class Level < AccountBlock::ApplicationRecord
		self.table_name = :levels
		has_many :account_levels
		has_many :accounts, through: :account_levels
		validates :name, uniqueness: true, presence: true
		validates :min_rewards, uniqueness: true, presence: true
		validates :max_rewards, uniqueness: true, presence: true
	end
end