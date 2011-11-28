When /^I visit the users page$/ do
  visit users_path
end

Then /^I should be on the users page$/ do
  current_path.should == users_path
end
