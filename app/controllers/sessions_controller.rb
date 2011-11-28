class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_gifts_path(user),
        :notice => "Hello #{user.name}! You are now logged in."
    else
      render 'new', :error => "Sorry. Invalid email or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', :notice => "You are now logged out."
  end
end
