require 'spec_helper.rb'

describe User do
  describe 'validations' do
    before(:each) do
      @user = Factory.build(:user)
    end

    it 'saves when all validations are met' do
      @user.save.should == true
      saved_user = User.first
      saved_user.name.should == @user.name
      saved_user.email.should == @user.email
    end

    it 'requires presence of name' do
      @user.name = nil
      @user.save.should == false
    end

    it 'requires presence of email' do
      @user.email = nil
      @user.save.should == false
    end

    it 'requires unique email address' do
      user1 = Factory.build(:user, :email => 'user@email.com')
      user1.save.should == true
      user2 = Factory.build(:user, :email => 'user@email.com')
      user2.save.should == false
    end

    it 'requires presence of password' do
      @user.password = nil
      @user.save.should == false
    end

    it 'has many gifts' do
      @user.gifts.should_not == nil
    end
  end

  describe '#purchase' do
    before(:each) do
      @user = Factory(:user)
    end

    context 'when gift is owned by another user' do
      before(:each) do
        @another_user = Factory(:user)
        @gift = Factory(:gift, :user => @another_user)
        @user.purchase(@gift)
        @gift = Gift.find(@gift)
      end

      it 'marks the gift as purchased' do
        @gift.purchased?.should == true
      end

      it 'assigns the correct user id to the purchased gift' do
        @gift.purchased_by_user_id.should == @user.id
      end
    end

    context 'when gift is owned by the same user' do
      before(:each) do
        @gift = Factory(:gift, :user => @user)
        @user.purchase(@gift)
        @gift = Gift.find(@gift)
      end

      it 'does not mark the gift as purchased' do
        @gift.purchased?.should == false
      end

      it 'does not assign a user id to the gift' do
        @gift.purchased_by_user_id.should == nil
      end
    end
  end

  describe '#return' do
    before(:each) do
      @user = Factory(:user)
      @gift = Factory(:gift)
    end

    context 'when purchased by this user' do
      before(:each) do
        @user.purchase(@gift)
        @return = @user.return(@gift)
      end

      it 'sets the gift to an unpurchased state' do
        @gift.purchased?.should == false
      end

      it 'returns true' do
        @return.should == true
      end
    end

    context 'when purchased by another user' do
      before(:each) do
        Factory(:user).purchase(@gift)
        @return = @user.return(@gift)
      end

      it 'leaves the gift in a purchased state' do
        @gift.purchased?.should == true
      end

      it 'returns false' do
        @return.should == false
      end
    end

    context 'when not already purchased' do
      before(:each) do
        @return = @user.return(@gift)
      end

      it 'leaves the gift in an unpurchased state' do
        @gift.purchased?.should == false
      end

      it 'returns false' do
        @return.should == false
      end
    end
  end
end
