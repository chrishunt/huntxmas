class GiftsController < ApplicationController
  before_filter :authenticate

  def index
    user = User.find(params[:user_id])
    @gifts = Gift.where('user_id = ?', user.id).order(:name)
    flash.now[:warning] = "#{user.name} has not added any gifts" if @gifts.empty?
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
    @gift = @user.gifts.build(gift_params)
    if @gift.save
      send_notifications_for(@user, @gift)
      redirect_to user_gifts_path(@user), notice: 'Your gift has been added!'
    else
      flash.now[:error] = 'Both name and url are required!'
      render 'new'
    end
  end

  def edit
    begin
      @gift = Gift.find(params[:id])
      @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to users_path
    end
  end

  def update
    @gift = Gift.find(params[:id])
    @user = User.find(params[:user_id])
    if current_user == @user && @gift.update_attributes(gift_params)
      redirect_to user_gifts_path(@gift.user), notice: 'Your gift has been updated!'
    else
      flash.now[:error] = 'Both name and url are required!'
      render 'edit'
    end
  end

  def destroy
    begin
      @user = User.find(params[:user_id])
      Gift.find(params[:id]).destroy
      redirect_to user_gifts_path(@user), notice: 'Your gift has been deleted!'
    rescue ActiveRecord::RecordNotFound
      redirect_to users_path
    end
  end

  def purchase
    begin
      @user = User.find(params[:user_id])
      @gift = Gift.find(params[:id])
      current_user.purchase(@gift)
      redirect_to user_gifts_path(@user), notice: 'Gift has been marked as purchased!'
    rescue ActiveRecord::RecordNotFound
      redirect_to users_path
    end
  end

  def return
    begin
      @user = User.find(params[:user_id])
      @gift = Gift.find(params[:id])
      if current_user.return(@gift)
        flash[:notice] = 'Gift is no longer marked as purchased!'
      else
        flash[:error] = 'Sorry. You cannot unmark gifts that you did not purchase!'
      end
      redirect_to user_gifts_path(@user)
    rescue ActiveRecord::RecordNotFound
      redirect_to users_path
    end
  end

  private

  def send_notifications_for(user, gift)
    GiftNotifierWorker.perform_async user.id, gift.id
  end

  def gift_params
    params.require(:gift).permit(:name, :url)
  end
end
