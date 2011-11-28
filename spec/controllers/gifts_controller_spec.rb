require 'spec_helper.rb'

describe GiftsController do
  before(:each) do
    @user = Factory(:user)
  end

  context 'when not logged in' do
    it 'redirects to login page' do
      get :index, :user_id => @user.id
      response.should redirect_to(login_path)

      get :new, :user_id => @user.id
      response.should redirect_to(login_path)

      post :create, :user_id => @user.id
      response.should redirect_to(login_path)
    end
  end

  context 'when logged in' do
    before(:each) do
      session[:user_id] = @user.id
    end

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

    describe '#new' do
      context 'when user id is valid' do
        before(:each) do
          get :new, :user_id => @user
        end

        it 'builds a new gift' do
          assigns(:gift).should_not be_nil
        end

        it 'assigns gift to current user' do
          assigns(:gift).user.should == @user
        end
      end

      context 'when user id is invalid' do
        before(:each) do
          get :new, :user_id => 100
        end

        it 'should not build a new gift' do
          assigns(:gift).should be_nil
        end

        it 'redirects to the user index' do
          response.should redirect_to(users_path)
        end
      end
    end

    describe '#create' do
      before(:each) do
        Gift.all.size.should == 0
        @gift = Factory.build(:gift, :user => @user)
      end

      context 'with valid gift attributes' do
        before(:each) do
          post :create, :user_id => @user, :gift => @gift.attributes
        end

        it 'saves gift in database' do
          Gift.all.size.should == 1
        end

        it 'assigns gift as instance variable' do
          assigns(:gift).name.should == @gift.name
          assigns(:gift).url.should == @gift.url
        end

        it 'redirects back to user gift list' do
          response.should redirect_to(user_gifts_path(@user))
        end
      end

      context 'with invalid gift attributes' do
        before(:each) do
          @gift.name = nil
          post :create, :user_id => @user, :gift => @gift.attributes
        end

        it 'should not redirect to gift list' do
          response.should_not be_redirect
        end
      end
    end
  end
end
