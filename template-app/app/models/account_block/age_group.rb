module AccountBlock
	class AgeGroup < AccountBlock::ApplicationRecord
		self.table_name = :age_groups
		has_many :accounts
	end
end