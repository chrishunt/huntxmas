When /^I visit the users page$/ do
  visit users_path
end

Then /^I should be on the users page$/ do
  current_path.should == users_path
end

Given /^I am on the users page$/ do
  visit users_path
end

Given /^there are (\d+) test users created$/ do |num|
  (0..num.to_i).each do |n|
    Factory(:user,
            :name     => "Test User #{n}",
            :email    => "test_user#{n}@domain.com",
            :password => "secret")
  end
end
