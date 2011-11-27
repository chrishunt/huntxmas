Given /^I have a gift saved$/ do
  @user ||= Factory(:user)
  Factory(:gift, :user => @user)
end

When /^I visit my gift list$/ do
  @user ||= Factory(:user)
  visit user_gifts_path @user
end

