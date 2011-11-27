require 'spec_helper.rb'

describe UsersController do
  describe '#new' do
    before(:each) do
      @user = Factory.build(:user)
      User.stub!(:new).and_return(@user)
      get :new
    end

    it 'should return a new user' do
      assigns(:user).should == @user
    end
  end

  describe '#create' do
    before(:each) do
      @user = Factory.build(:user)
    end

    it 'creates the new user' do
      post :create, :user => @user.attributes
      @user.attributes.each do |attr, value|
        assigns(:user).send(attr).should == value unless attr == 'password_digest'
      end
    end

    it 'redirects to user path if successful' do
      pending "Having trouble testing"
      post :create, :user => @user
      response.should be_redirect
    end

    it 'redirects to new user form if unsuccessful' do
      pending "Having trouble testing"
      @user.name = nil # create invalid user
      post :new, :user => @user
      current_path.should == new_user_path
    end
  end
end
