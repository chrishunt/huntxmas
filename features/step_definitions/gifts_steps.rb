Given /^I have a gift saved$/ do
  Factory(:gift)
end

When /^I visit my gift list$/ do
  visit user_gifts_path Factory(:user)
end

