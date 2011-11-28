Given /^I have a test user created$/ do
  Factory(:user,
          :name     => 'Test User',
          :email    => 'test@domain.com',
          :password => 'secret')
end

Given /^I am logged in$/ do
  visit login_path
  fill_in 'email', :with => user.email
  fill_in 'password', :with => user.password
  click_button 'Login'
end

Given /^I am not logged in$/ do
  visit logout_path
end
