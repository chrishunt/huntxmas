class GiftNotifier
  attr_reader :user_id, :gift_id

  def initialize(user_id, gift_id)
    @user_id = user_id
    @gift_id = gift_id
  end

  def send_notifications
    User.with_email_notifications.where(
      "id <> ?", user_id
    ).each do |to|
      email = GiftMailer.gift_added_notification(user, to, gift)
      email.deliver if email
    end
  end

  private

  def user
    @user ||= User.find(user_id)
  end

  def gift
    @gift ||= Gift.find(gift_id)
  end
end
