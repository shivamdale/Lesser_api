module AccountBlock
	class Device < AccountBlock::ApplicationRecord
		self.table_name = :devices
		belongs_to :account
	end
end