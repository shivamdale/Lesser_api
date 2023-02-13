module AccountBlock
  class SmsAccount < Account
    include Wisper::Publisher
    validates :full_phone_number, uniqueness: true, presence: true
    validates :email, uniqueness: true, presence: true
    has_many :push_notifications, as: :push_notificable, class_name: "BxBlockPushNotifications::PushNotification"
  end
end
