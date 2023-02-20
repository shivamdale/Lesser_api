class BxBlockPushNotifications::PushNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default, retry: 3
  require 'fcm'

  def perform(push_notification_id)
      push_notification = BxBlockPushNotifications::PushNotification.find_by_id(push_notification_id)
      account = AccountBlock::Account.find_by(id: push_notification.account_id)
      device_ids =  account.devices.pluck(:device_id)
      device_ids.each do |device_id|
        if push_notification.push_notificable.activated
          fcm_client = FCM.new(ENV['FCM_SEVER_KEY']) # set your FCM_SERVER_KEY
          options = { priority: 'high',
                      data: {
                        message: push_notification.remarks,
                        account_id: push_notification.account_id
                      },
                      notification: {
                      body: push_notification.remarks,
                      sound: 'default'
                      }
                    }
          fcm_client.send(device_id, options)
        end
      end
    rescue Exception => e
      e
    end
end