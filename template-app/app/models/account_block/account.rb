module AccountBlock
  class Account < AccountBlock::ApplicationRecord
    self.table_name = :accounts

    include Wisper::Publisher

    has_secure_password
    before_validation :parse_full_phone_number
    before_create :generate_api_key
    has_one :blacklist_user, class_name: 'AccountBlock::BlackListUser', dependent: :destroy
    belongs_to :role, class_name: 'BxBlockRolesPermissions::Role', optional: true
    belongs_to :gender, optional: :true
    belongs_to :city, optional: :true
    belongs_to :country, optional: :true
    belongs_to :age_group, optional: :true
    has_one_attached :image, dependent: :destroy
    has_one :recycle_bottle, class_name: 'BxBlockDashboard::RecycleBottle'
    has_many :account_levels
    has_many :levels, through: :account_levels
    has_many :devices

    enum status: %i[regular suspended deleted]

    scope :active, -> { where(activated: true) }
    scope :existing_accounts, -> { where(status: ['regular', 'suspended']) }
    validates :full_phone_number, uniqueness: true

    def send_deposit_bottle_notifications(no_of_bottles)
      message = "#{no_of_bottles} bottles. Thank you, your bottles was deposited. Rewards points will be added to your account soon. X CO2 saved. "
      self.push_notifications.create(account_id: self.id, remarks: message)
    end

    private

    def parse_full_phone_number
      phone = Phonelib.parse(full_phone_number)
      self.full_phone_number = phone.sanitized
      self.country_code      = phone.country_code
      self.phone_number      = phone.raw_national
    end

    def generate_api_key
      loop do
        @token = SecureRandom.base64.tr('+/=', 'Qrt')
        break @token unless Account.exists?(unique_auth_id: @token)
      end
      self.unique_auth_id = @token
    end
  end
end
