class UsersController < ApplicationController
  before_filter :authenticate, only: [:index, :edit, :update]

  def index
    @users = User.order(:name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
    @user = current_user
    if @user.update_attributes user_params
      redirect_to user_gifts_path(@user),
        notice: "Your account details have been updated!"
    else
      flash.now[:error] = "Sorry! There were errors updating your account."
      render 'edit'
    end
  end

  private

  def user_params
    @user_params ||= begin
      params.require(:user).permit([
        :email,
        :email_notifications,
        :name,
        :password,
        :password_confirmation
      ]).tap do |params|
        params[:email] = params[:email].to_s.downcase
        params[:password_confirmation] ||= params[:password]
      end
    end
  end
end
