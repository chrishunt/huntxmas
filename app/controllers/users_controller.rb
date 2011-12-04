class UsersController < ApplicationController
  before_filter :authenticate, :only => :index

  def index
    @users = User.order(:name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.email = @user.email.try(:downcase)
    if @user.save
      redirect_to login_path, :notice => "Account created! You may now login."
    else
      flash.now[:error] = "Sorry! There were errors creating your account."
      render 'new'
    end
  end
end
