require 'spec_helper.rb'

describe UsersController do
  describe '#index' do
    before(:each) do
      @user1 = FactoryGirl.create(:user, name: 'Sam')
      @user2 = FactoryGirl.create(:user, name: 'Bob')
      @users = [@user2, @user1]
    end

    context 'when logged in' do
      before(:each) do
        session[:user_id] = @user1.id
        get :index
      end

      it 'returns list of all users, sorted by name' do
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
      @user = FactoryGirl.build(:user)
      User.stub!(:new).and_return(@user)
      get :new
    end

    it 'returns a new user' do
      assigns(:user).should == @user
    end
  end

  describe '#edit' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    context 'when logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      context 'and passing the same user id' do
        before(:each) do
          get :edit, id: @user.id
        end

        it 'passes the current_user to the view' do
          assigns(:user).name.should  == @user.name
          assigns(:user).email.should == @user.email
        end
      end

      context 'and passing a different user id' do
        before(:each) do
          another_user = FactoryGirl.create(:user)
          get :edit, id: another_user.id
        end

        it 'passes the current_user to the view' do
          assigns(:user).name.should  == @user.name
          assigns(:user).email.should == @user.email
        end
      end

      context 'and id is invalid' do
        before(:each) do
          get :edit, id: 100
        end

        it 'passes the current_user to the view' do
          assigns(:user).name.should  == @user.name
          assigns(:user).email.should == @user.email
        end
      end
    end

    context 'when not logged in' do
      before(:each) do
        get :edit, id: @user.id
      end

      it 'redirects to login page' do
        response.should redirect_to login_path
      end
    end
  end

  describe '#create' do
    before(:each) do
      @user = FactoryGirl.build(:user)
      User.all.count.should == 0
    end

    context 'with valid parameters' do
      before(:each) do
        post :create, user: {
          name: @user.name,
          email: @user.email,
          password: @user.password }
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
        post :create, user: {
          name: @user.name,
          email: @user.email.upcase,
          password: @user.password }
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
        post :create, user: {name: nil}
      end

      it 'does not save a user in the database' do
        User.all.count.should == 0
      end

      it 'does not redirect' do
        response.should_not be_redirect
      end
    end
  end

  describe '#update' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @attributes = {
        name: 'Bob',
        email: 'bob@example.com',
        password: 'newsecret' }
    end

    context 'when logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      context 'with valid parameters' do
        before(:each) do
          post :update, id: @user, user: @attributes
        end

        it 'updates the attributes in the database' do
          user = User.first
          user.name.should  == @attributes[:name]
          user.email.should == @attributes[:email]
        end

        it 'assigns the user instance variable' do
          assigns(:user).name.should  == @attributes[:name]
          assigns(:user).email.should == @attributes[:email]
        end

        it "redirects to the user's gift list" do
          response.should redirect_to(user_gifts_path(@user))
        end
      end

      context 'with capitalized email address' do
        before(:each) do
          @attributes[:email] = @attributes[:email].upcase
          post :update, id: @user, user: @attributes
        end

        it 'converts the email to lowercase before save' do
          User.first.email.should == @attributes[:email].downcase
        end

        it 'assigns the user variable with lowercase email' do
          assigns(:user).email.should == @attributes[:email].downcase
        end
      end

      context 'with invalid parameters' do
        before(:each) do
          post :update, id: @user, user: { name: nil }
        end

        it 'does not update the user' do
          user = User.first
          user.name.should == @user.name
          user.email.should == @user.email
        end

        it 'does not redirect' do
          response.should_not be_redirect
        end
      end

      context 'and updating another user' do
        before(:each) do
          @another_user = FactoryGirl.create(:user)
          post :update, id: @another_user, user: @attributes
        end

        it 'still updates the logged in user' do
          User.first.name.should == @attributes[:name]
          User.last.name.should  == @another_user.name
        end
      end
    end

    context 'when not logged in' do
      before(:each) do
        post :update, id: @user, user: @attributes
      end

      it 'does not update the user' do
        User.first.name.should  == @user.name
        User.first.email.should == @user.email
      end

      it 'redirects to the login page' do
        response.should redirect_to(login_path)
      end
    end
  end
end
