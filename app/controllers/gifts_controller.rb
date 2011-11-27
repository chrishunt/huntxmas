class GiftsController < ApplicationController
  def index
    @gifts = Gift.where('user_id = ?', params[:user_id])
  end
end
