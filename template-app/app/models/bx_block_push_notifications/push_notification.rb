module BxBlockPushNotifications
  class PushNotification < ApplicationRecord
    require 'fcm'
    self.table_name = :push_notifications

    belongs_to :push_notificable, polymorphic: true
    belongs_to :account, class_name: "AccountBlock::Account"
    validates :remarks, presence:true
    after_create :send_push_notification

    def send_push_notification
      BxBlockPushNotifications::PushNotificationWorker.perform_async(self.id)
    end
  end
end
