Given /^I am on the login page$/ do
  visit login_path
end

Given /^I am on the account creation page$/ do
  visit new_user_path
end

Given /^I have already created an account with the email '(.*)'$/ do |email|
    Factory(:user, :email => email)
end

Then /^I should be on the account creation page$/ do
  current_path.should == new_user_path
end

Then /^I should be on the login page$/ do
  current_path.should == login_path
end
