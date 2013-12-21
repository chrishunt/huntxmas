class UsersController < ApplicationController
  before_filter :authenticate, only: [:index, :edit, :update]

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
      redirect_to login_path, notice: "Account created! You may now login."
    else
      flash.now[:error] = "Sorry! There were errors creating your account."
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    attrs = params[:user]
    attrs[:email] = attrs[:email].downcase if attrs[:email]
    @user = current_user
    if @user.update_attributes attrs
      redirect_to user_gifts_path(@user),
        notice: "Your account details have been updated!"
    else
      flash.now[:error] = "Sorry! There were errors updating your account."
      render 'edit'
    end
  end
end
