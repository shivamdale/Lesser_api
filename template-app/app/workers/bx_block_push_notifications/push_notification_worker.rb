class BxBlockPushNotifications::PushNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default, retry: 3
  require 'fcm'

  def perform(push_notification_id)
      push_notification = BxBlockPushNotifications::PushNotification.find_by_id(push_notification_id)
      device_id = AccountBlock::Account.find_by(id: push_notification.account_id).device_id
      if push_notification.push_notificable.activated && push_notification.push_notificable.device_id
        fcm_client = FCM.new('AAAAbPVP7PI:APA91bGrSncNSqYz9ochNmI22oZQDolHGxY996176rI9pbCZLL_QqStkjQ9QRbQjZG1SQ-VcpPaC83Ijdj3_zMvf8CgTjQJy0v2jmLTzZEJbqSSQD1MHGYL-lXWUbHNFCLMB8ofrYlRg') # set your FCM_SERVER_KEY
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
        registration_id = push_notification.push_notificable.device_id
        fcm_client.send(registration_id, options)
      end
    rescue Exception => e
      e
    end
end