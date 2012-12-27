class GiftMailer < ActionMailer::Base
  default from: 'no-reply@huntxmas.com'

  def gift_added_notification(from, to, gift)
    @from = from
    @to = to
    @gift = gift

    attachments.inline['snowman.png'] = File.read(
      'app/assets/images/snowman.png'
    )

    mail(
      to: to.email,
      subject: "#{from.name} added a new Christmas gift"
    )
  end
end
