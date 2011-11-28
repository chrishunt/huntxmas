Given /^I have an account created$/ do
  Factory(:user)
end

Given /^I am logged in$/ do
  @user ||= Factory(:user)
  visit login_path
  fill_in 'email', :with => @user.email
  fill_in 'password', :with => @user.password
  click_button 'Login'
end
