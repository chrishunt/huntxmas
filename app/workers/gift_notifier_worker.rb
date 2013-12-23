class GiftNotifierWorker
  include Sidekiq::Worker

  def perform(user_id, gift_id)
    GiftNotifier.new(user_id, gift_id).send_notifications
  end
end
