require 'spec_helper.rb'

describe GiftsController do
  describe '#index' do
    before(:each) do
      @user1 = Factory(:user)
      @user2 = Factory(:user)
      @gift1 = Factory(:gift, :user => @user1)
      @gift2 = Factory(:gift, :user => @user2)
      @gift3 = Factory(:gift, :user => @user1)
      get :index, :user_id => @user1
    end

    it "returns list of all user's gifts" do
      assigns(:gifts).should == [@gift1, @gift3]
    end
  end
end
