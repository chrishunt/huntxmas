########
# Given
########

Given /^I have a gift saved$/ do
  gift
end

Given /^I am on the gift edit page$/ do
  visit edit_user_gift_path(user, gift)
end

Given /^I am on my gift list$/ do
  visit user_gifts_path(user)
end

########
# When
########

When /^I visit my gift list$/ do
  visit user_gifts_path(user)
end

When /^I visit the add gift page$/ do
  visit new_user_gift_path(user)
end

########
# Then
########

Then /^I should be on my gift list$/ do
  page.current_path.should == user_gifts_path(user)
end

Then /^I should be on the add gift page$/ do
  page.current_path.should == new_user_gift_path(user)
end

Then /^I should be on the gift edit page$/ do
  page.current_path.should == edit_user_gift_path(user, gift)
end
