class GiftsController < ApplicationController
  before_filter :authenticate

  def index
    @gifts = Gift.where('user_id = ?', params[:user_id])
  end

  def new
    begin
      @user = User.find(params[:user_id])
      @gift = @user.gifts.build
    rescue ActiveRecord::RecordNotFound
      redirect_to users_path
    end
  end

  def create
    @user = User.find(params[:user_id])
    @gift = @user.gifts.build(params[:gift])
    if @gift.save
      redirect_to user_gifts_path(@user), :notice => 'Your gift has been added!'
    else
      flash.now[:error] = 'Both name and url are required!'
      render 'new'
    end
  end

  def edit
    begin
      @gift = Gift.find(params[:id])
      @user = @gift.user
    rescue ActiveRecord::RecordNotFound
      redirect_to users_path
    end
  end

  def update
    @gift = Gift.find(params[:id])
    @user = @gift.user
    if @gift.update_attributes(params[:gift])
      redirect_to user_gifts_path(@gift.user), :notice => 'Your gift has been updated!'
    else
      flash.now[:error] = 'Both name and url are required!'
      render 'edit'
    end
  end
end
