class AccountLevel < AccountBlock::ApplicationRecord
	self.table_name = :account_levels
	belongs_to :account, class_name: 'AccountBlock::Account'
	belongs_to :level, class_name: 'BxBlockLevel::Level'
end