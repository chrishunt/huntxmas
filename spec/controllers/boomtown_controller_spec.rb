require 'spec_helper'

describe BoomtownController do
  context '#boom' do
    it 'raise a BoomtownException' do
      expect {
        get :boomtown
      }.to raise_error BoomtownController::BoomtownException
    end
  end
end
