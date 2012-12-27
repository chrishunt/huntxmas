class NewGiftNotifier
  def notifications_for(user)
    User.with_email_notifications.each do |to|
      email = GiftMailer.gift_added_notification(user, to)
      email.deliver if email
    end
  end
end
