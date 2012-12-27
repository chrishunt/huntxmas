class GiftMailer < ActionMailer::Base
  default from: 'no-reply@huntxmas.com'

  def gift_added_notification(from, to, gift)
    mail(
      to: to.email,
      subject: "#{from.name} added a new Christmas gift"
    )
  end
end
