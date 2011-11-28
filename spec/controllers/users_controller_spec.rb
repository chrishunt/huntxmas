require 'spec_helper.rb'

describe UsersController do
  describe '#index' do
    before(:each) do
      @user1 = Factory(:user)
      @user2 = Factory(:user)
      @users = [@user1, @user2]
    end

    context 'when logged in' do
      before(:each) do
        session[:user_id] = @user1.id
        get :index
      end

      it 'returns list of all users' do
        assigns(:users).should == @users
      end
    end

    context 'when not logged in' do
      before(:each) do
        get :index
      end

      it 'returns no user list' do
        assigns(:users).should == nil
      end

      it 'redirects to login page' do
        response.should redirect_to(login_path)
      end
    end
  end

  describe '#new' do
    before(:each) do
      @user = Factory.build(:user)
      User.stub!(:new).and_return(@user)
      get :new
    end

    it 'returns a new user' do
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
      response.should redirect_to(new_user_path)
    end
  end
end
