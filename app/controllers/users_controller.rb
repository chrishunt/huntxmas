class UsersController < ApplicationController
  before_filter :authenticate, :only => :index

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to login_path, :notice => "Account created! You may now login."
    else
      render 'new', :error => "Sorry! There were errors creating your account."
    end
  end
end
