require 'spec_helper.rb'

describe GiftsController do
  describe '#index' do
    before(:each) do
      @user = Factory(:user)
      @gift = Factory(:gift, :user => @user)
      @gifts = [@gift]
      get :index, :user => @user
    end

    it 'returns list of all gifts' do
      assigns(:gifts).should == @gifts
    end
  end
end
