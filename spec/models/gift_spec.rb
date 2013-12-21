require 'spec_helper.rb'

describe Gift do
  describe 'validations' do
    before(:each) do
      @gift = FactoryGirl.build(:gift)
    end

    it 'saves a gift when all validations are passing' do
      @gift.save.should == true
      saved_gift = Gift.first
      saved_gift.name.should == @gift.name
      saved_gift.url.should  == @gift.url
      saved_gift.user.should == @gift.user
    end

    it 'validates presence of name' do
      @gift.name = nil
      @gift.save.should == false
    end

    it 'validates presence of url' do
      @gift.url = nil
      @gift.save.should == false
    end

    it 'validates precense of user' do
      @gift.user = nil
      @gift.save.should == false
    end
  end

  describe '#sell!' do
    before(:each) do
      @creator      = FactoryGirl.create(:user)
      @another_user = FactoryGirl.create(:user)
    end

    context 'when purchased by another user' do
      before(:each) do
        gift = FactoryGirl.create(:gift, user: @creator)
        gift.sell!(@another_user)
        @gift = Gift.find(gift)
      end

      it 'sets the perchased_by_user_id to the correct user' do
        @gift.purchased_by_user_id.should == @another_user.id
      end
    end

    context 'when purchased by the gift creater' do
      before(:each) do
        gift = FactoryGirl.create(:gift, user: @creator)
        gift.sell!(@creator)
        @gift = Gift.find(gift)
      end

      it 'does not set the purchased_by_user_id' do
        @gift.purchased_by_user_id.should == nil
      end
    end
  end

  describe '#purchased?' do
    before(:each) do
      @gift = FactoryGirl.create(:gift)
    end

    it 'returns true when the gift has been purchased' do
      @gift.stub(:purchased_by_user_id).and_return(1)
      @gift.purchased?.should == true
    end

    it 'returns false when the gift has not been purchased' do
      @gift.stub(:purchased_by_user_id).and_return(nil)
      @gift.purchased?.should == false
    end
  end

  describe '#purchased_by?' do
    before(:each) do
      @gift = FactoryGirl.create(:gift)
      @user = FactoryGirl.create(:user)
      @user.purchase(@gift)
    end

    it 'returns true if the gift was purchased by the user' do
      @gift.purchased_by?(@user).should == true
    end

    it 'returns false if the gift was not purchased by the user' do
      @gift.purchased_by?(FactoryGirl.create(:user)).should == false
    end
  end

  describe '#return!' do
    before(:each) do
      gift = FactoryGirl.create(:gift, purchased_by_user_id: 1)
      gift.return!
      @gift = Gift.find(gift)
    end

    it 'returns the gift to an unpurchased state' do
      @gift.purchased?.should == false
    end
  end

  describe '#purchaser' do
    before(:each) do
      @gift = FactoryGirl.create(:gift)
    end

    context 'when gift is purchased' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @user.purchase(@gift)
      end

      it 'returns the user that purchased the gift' do
        @gift.purchaser.should == @user
      end
    end

    it 'returns nil when gift is not purchased' do
      @gift.purchaser.should == nil
    end
  end
end
