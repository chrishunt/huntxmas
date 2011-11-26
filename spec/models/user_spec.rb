require 'spec_helper.rb'

describe User do
  before(:each) do
    @user = Factory.build(:user)
  end

  it 'saves when all validations are met' do
    @user.save.should == true
    saved_user = User.first
    saved_user.name.should == @user.name
    saved_user.email.should == @user.email
  end

  it 'requires presence of name' do
    @user.name = nil
    @user.save.should == false
  end

  it 'requires presence of email' do
    @user.email = nil
    @user.save.should == false
  end

  it 'requires unique email address' do
    user1 = Factory.build(:user, :email => 'user@email.com')
    user1.save.should == true
    user2 = Factory.build(:user, :email => 'user@email.com')
    user2.save.should == false
  end

  it 'requires presence of password' do
    @user.password = nil
    @user.save.should == false
  end

  it 'has many gifts' do
    @user.gifts.should_not == nil
  end
end
