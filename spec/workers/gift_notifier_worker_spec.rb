require 'spec_helper'

describe GiftNotifierWorker do
  describe '#perform' do
    it 'sends a gift notification' do
      user_id, gift_id = 1, 2

      notifier = double('GiftNotifier')

      GiftNotifier
        .should_receive(:new)
        .with(user_id, gift_id)
        .and_return(notifier)

      notifier.should_receive(:send_notifications)

      GiftNotifierWorker.perform_async user_id, gift_id
    end
  end
end
