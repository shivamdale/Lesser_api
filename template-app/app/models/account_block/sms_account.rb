module AccountBlock
  class SmsAccount < Account
    include Wisper::Publisher
    validates :full_phone_number, uniqueness: true, presence: true
    validates :email, uniqueness: true, presence: true
    has_many :push_notifications, as: :push_notificable, class_name: "BxBlockPushNotifications::PushNotification", dependent: :destroy
    has_one :qr_code, as: :qrable, class_name: 'BxBlockQrCodes::QrCode', dependent: :destroy
    after_create :create_qr_code, :generate_qr

    def full_name
      "#{first_name} #{last_name}"
    end

    private

      def generate_qr
        qr_code.generate_code(full_phone_number)
      end

  end
end
