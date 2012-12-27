require 'spec_helper'

describe NewGiftNotifier do
  describe '#notifications_for' do
    it 'sends an email to all users with notifications enabled' do
      2.times do
        FactoryGirl.create(:user) do |user|
          user.email_notifications = true
          user.save
        end
      end

      FactoryGirl.create(:user)

      GiftMailer.should_receive(:gift_added_notification).twice

      subject.notifications_for(nil)
    end
  end
end
