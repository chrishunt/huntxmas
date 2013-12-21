class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_gifts_path(user),
        notice: "Hello #{user.name}! You are now logged in."
    else
      flash.now[:error] = "Sorry! Invalid email or password."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You are now logged out."
  end
end
