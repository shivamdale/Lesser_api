module AccountBlock
	class City < AccountBlock::ApplicationRecord
		self.table_name = :cities
		has_many :accounts
	end
end