class BoomtownController < ActionController::Base
  BoomtownException = Class.new(StandardError)

  def boomtown
    raise BoomtownException.new 'BOOOOOM!'
  end
end
