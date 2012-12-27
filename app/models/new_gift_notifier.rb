class NewGiftNotifier
  def notifications_for(user, gift)
    User.with_email_notifications.where(
      "id IS NOT ?", user.id
    ).each do |to|
      email = GiftMailer.gift_added_notification(user, to, gift)
      email.deliver if email
    end
  end
end
