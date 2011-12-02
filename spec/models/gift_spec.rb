require 'spec_helper.rb'

describe Gift do
  before(:each) do
    @gift = Factory.build(:gift)
  end

  it 'saves a gift when all validations are passing' do
    @gift.save.should == true
    saved_gift = Gift.first
    saved_gift.name.should == @gift.name
    saved_gift.url.should  == @gift.url
    saved_gift.user.should == @gift.user
  end

  it 'validates presence of name' do
    @gift.name = nil
    @gift.save.should == false
  end

  it 'validates presence of url' do
    @gift.url = nil
    @gift.save.should == false
  end

  it 'validates precense of user' do
    @gift.user = nil
    @gift.save.should == false
  end
end
