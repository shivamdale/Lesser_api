module AccountBlock
	class Gender < AccountBlock::ApplicationRecord
		self.table_name = :genders
		has_many :accounts
	end
end