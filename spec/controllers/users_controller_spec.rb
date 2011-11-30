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
      User.all.count.should == 0
    end

    context 'with valid parameters' do
      before(:each) do
        post :create, :user => {
          :name     => @user.name,
          :email    => @user.email,
          :password => @user.password }
      end

      it 'saves the new user in the database' do
        User.all.count.should == 1
      end

      it 'assigns the user instance variable' do
        assigns(:user).name.should     == @user.name
        assigns(:user).email.should    == @user.email
        assigns(:user).password.should == @user.password
      end

      it 'redirects to the login page' do
        response.should redirect_to(login_path)
      end
    end

    context 'with capitalized email address' do
      before(:each) do
        post :create, :user => {
          :name     => @user.name,
          :email    => @user.email.upcase,
          :password => @user.password }
      end

      it 'converts the email to lowercase before save' do
        User.first.email.should == @user.email.downcase
      end

      it 'assigns the user variable with lowercase email' do
        assigns(:user).email.should == @user.email.downcase
      end
    end

    context 'with invalid parameters' do
      before(:each) do
        post :create, :user => {:name => nil}
      end

      it 'does not save a user in the database' do
        User.all.count.should == 0
      end

      it 'does not redirect' do
        response.should_not be_redirect
      end
    end
  end
end
