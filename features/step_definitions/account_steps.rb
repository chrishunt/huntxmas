Given /^I am on the login page$/ do
  visit login_path
end

Given /^I am on the account creation page$/ do
  visit new_user_path
end

Then /^I should be on the account creation page$/ do
  current_path.should == new_user_path
end

Then /^I should be on the login page$/ do
  current_path.should == login_path
end
