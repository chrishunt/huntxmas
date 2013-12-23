require 'spec_helper'

describe GiftNotifier do
  subject { GiftNotifier }

  describe '#send_notifications' do
    it 'sends an email to all users with notifications enabled' do
      gift = FactoryGirl.create(:gift)
      user = FactoryGirl.create(:user)

      2.times.map do
        FactoryGirl.create(:user) do |user|
          user.email_notifications = true
          user.save
        end
      end

      FactoryGirl.create(:user)

      GiftMailer.should_receive(:gift_added_notification).twice

      subject.new(user.id, gift).send_notifications
    end

    it 'does not notify users of their own gifts' do
      gift = FactoryGirl.create(:gift)
      user = FactoryGirl.create(:user)
      user.email_notifications = true
      user.save

      GiftMailer.should_not_receive(:gift_added_notification)

      subject.new(user.id, gift.id).send_notifications
    end
  end
end
