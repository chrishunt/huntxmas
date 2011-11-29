class UsersController < ApplicationController
  before_filter :authenticate, :only => :index

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to login_path, :notice => "Account created! You may now login."
    else
      flash.now[:error] = "Sorry! All fields are required to continue."
      render 'new'
    end
  end
end
