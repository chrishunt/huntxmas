class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account Created"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  end
end
