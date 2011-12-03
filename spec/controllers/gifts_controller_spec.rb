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
        @user1 = Factory(:user, :name => 'Bob')
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

        it 'assigns user instance variable' do
          assigns(:user).should_not be_nil
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

    describe '#edit' do
      before(:each) do
        @gift = Factory(:gift,
                        :name => 'Book',
                        :url  => 'http://books.com',
                        :user => @user)
      end

      context 'with valid id' do
        before(:each) do
          get :edit, :user_id => @user, :id => @gift
        end

        it 'assigns gift as instance variable' do
          assigns(:gift).name.should == @gift.name
          assigns(:gift).url.should  == @gift.url
        end

        it 'assigns user as instance variable' do
          assigns(:user).name.should  == @user.name
          assigns(:user).email.should == @user.email
        end
      end

      context 'with invalid id' do
        before(:each) do
          get :edit, :user_id => @user, :id => 100
        end

        it 'redirects to the user index' do
          response.should redirect_to(users_path)
        end
      end
    end

    describe '#update' do
      before(:each) do
        @gift = Factory(:gift, :user => @user)
      end

      context 'with valid gift attributes' do
        context 'as the correct user' do
          before(:each) do
            put :update,
              :user_id => @user,
              :id      => @gift,
              :gift    => { :name => 'Xbox 360', :url => 'http://xbox.com' }
          end

          it 'updates gift record in database' do
            saved = Gift.find(@gift)
            saved.name.should == 'Xbox 360'
            saved.url.should  == 'http://xbox.com'
          end

          it 'assigns gift as instance variable' do
            assigns(:gift).name.should == 'Xbox 360'
            assigns(:gift).url.should  == 'http://xbox.com'
          end

          it 'assigns user as instance variable' do
            assigns(:user).id.should == @user.id
          end

          it 'redirects back to user gift list' do
            response.should redirect_to(user_gifts_path(@user))
          end
        end

        context 'as another user' do
          before(:each) do
            put :update,
              :user_id => Factory(:user),
              :id      => @gift,
              :gift    => { :name => 'Xbox 360', :url => 'http://xbox.com' }
          end

          it 'does not update gift' do
            saved = Gift.find(@gift)
            saved.name.should == @gift.name
            saved.url.should  == @gift.url
          end

          it 'does not redirect' do
            response.should_not be_redirect
          end
        end
      end

      context 'with invalid gift attributes' do
        before(:each) do
          put :update,
            :user_id => @user,
            :id      => @gift,
            :gift    => { :name => nil, :url => @gift.url }
        end

        it 'does not redirect' do
          response.should_not be_redirect
        end
      end
    end

    describe '#destroy' do
      before(:each) do
        @gift = Factory(:gift, :user => @user)
        Gift.all.count.should == 1
      end

      context 'with valid gift id' do
        before(:each) do
          delete :destroy, :user_id => @user, :id => @gift
        end

        it 'deletes the gift from the database' do
          Gift.all.count.should == 0
        end

        it 'does not assign gift item' do
          assigns(:gift).should be_nil
        end

        it 'redirects to the gift list' do
          response.should redirect_to(user_gifts_path(@user))
        end
      end

      context 'with invalid gift id' do
        before(:each) do
          delete :destroy, :user_id => @user, :id => @gift.id + 1
        end

        it 'should not delete a gift' do
          Gift.all.count.should == 1
        end

        it 'should redirect to users page' do
          response.should redirect_to users_path
        end
      end
    end

    describe '#purchase' do
      before(:each) do
        @gift = Factory(:gift, :user => @user)
      end

      context 'with an invalid gift id' do
        before(:each) do
          get :purchase, :user_id => @user.id, :id => 100
        end

        it 'redirects to users index' do
          response.should redirect_to(users_path)
        end
      end

      context 'as another user' do
        before(:each) do
          another_user = Factory(:user)
          session[:user_id] = another_user.id
          get :purchase, :user_id => @user.id, :id => @gift.id
        end

        it 'assigns the correct gift' do
          assigns(:gift).should == @gift
        end

        it 'marks the gift as purchased' do
          assigns(:gift).purchased?.should == true
        end

        it 'assigns the currently logged in user as the purchaser' do
          assigns(:gift).purchased_by_user_id.should == session[:user_id]
        end

        it "redirects to the gift owner's list" do
          response.should redirect_to(user_gifts_path(@gift.user))
        end
      end

      context 'as the gift creater' do
        before(:each) do
          get :purchase, :user_id => @user.id, :id => @gift.id
        end

        it 'assigns the correct gift' do
          assigns(:gift).should == @gift
        end

        it 'does not mark the gift as purchased' do
          assigns(:gift).purchased?.should == false
        end

        it "redirects to the gift owner's list" do
          response.should redirect_to(user_gifts_path(@gift.user))
        end
      end
    end

    describe '#return' do
      before(:each) do
        @gift = Factory(:gift, :user => Factory(:user))
      end

      context 'when the gift has been purchased by the current user' do
        before(:each) do
          @user.purchase(@gift)
          get :return, :user_id => @gift.user, :id => @gift
        end

        it 'returns the gift to an unpurchased state' do
          assigns(:gift).purchased?.should == false
        end

        it "redirects to the gift owner's gift list" do
          response.should redirect_to(user_gifts_path(@gift.user))
        end
      end

      context 'when the gift has been purchased by a different user' do
        before(:each) do
          @another_user = Factory(:user)
          @another_user.purchase(@gift)
          get :return, :user_id => @gift.user, :id => @gift
        end

        it 'leaves the gift in a purchased state' do
          assigns(:gift).purchased?.should == true
        end

        it "redirects to the gift owner's gift list" do
          response.should redirect_to(user_gifts_path(@gift.user))
        end
      end

      context 'with an invalid gift id' do
        before(:each) do
          get :return, :user_id => @gift.user, :id => 100
        end

        it 'redirects to the users path' do
          response.should redirect_to(users_path)
        end
      end
    end
  end
end
