require 'spec_helper'

describe NewGiftNotifier do
  describe '#notifications_for' do
    it 'sends an email to all users with notifications enabled' do
      user = FactoryGirl.create(:user)

      2.times do
        FactoryGirl.create(:user) do |user|
          user.email_notifications = true
          user.save
        end
      end

      FactoryGirl.create(:user)

      GiftMailer.should_receive(:gift_added_notification).twice

      subject.notifications_for user, nil
    end

    it 'does not notify users of their own gifts' do
      user = FactoryGirl.create(:user)
      user.email_notifications = true
      user.save

      GiftMailer.should_not_receive(:gift_added_notification)

      subject.notifications_for user, nil
    end
  end
end
