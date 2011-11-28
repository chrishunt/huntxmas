Given /^I have a gift saved$/ do
  Factory(:gift, :user => user)
end

When /^I visit my gift list$/ do
  visit user_gifts_path user
end

Then /^I should be on my gift list$/ do
  page.current_path.should == user_gifts_path(user)
end

When /^I visit the add gift page$/ do
  visit new_user_gift_path(user)
end
