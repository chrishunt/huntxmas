require 'spec_helper.rb'

describe SessionsController do
  describe '#create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      session[:user_id].should == nil
    end

    context 'when using the correct password' do
      it 'saves the user_id in the session' do
        post :create, :email => @user.email, :password => @user.password
        session[:user_id].should == @user.id
      end
    end

    context 'when using the wrong password' do
      it 'does not save the user_id in the session' do
        post :create, :email => @user.email, :password => 'wrong'
        session[:user_id].should == nil
      end
    end

    context 'when capitalizing the email' do
      it 'saves the user_id in the session' do
        post :create, :email => @user.email.upcase, :password => @user.password
        session[:user_id].should == @user.id
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    context 'when already logged in' do
      before(:each) do
        session[:user_id] = @user.id
        session[:user_id].should == @user.id
        delete :destroy
      end

      it 'clears user_id from the session hash' do
        session[:user_id].should == nil
      end
    end

    context 'when not logged in' do
      before(:each) do
        session[:user_id] = nil
        session[:user_id].should == nil
        delete :destroy
      end

      it 'clears user_id from the session hash' do
        session[:user_id].should == nil
      end
    end
  end
end
