Then /^I should see '(.*)'$/ do |text|
  page.should have_content(text)
end

Then /^I should not see '(.*)'$/ do |text|
  page.should_not have_content(text)
end

Then /^I should see selector '(.*)'$/ do |selector|
  page.should have_selector(selector)
end

When /^I fill in '(.*)' with '(.*)'$/ do |id, text|
  fill_in id, :with => text
end

When /^I click the button '(.*)'$/ do |text|
  click_button text
end

When /^I click the link '(.*)'$/ do |text|
  click_link text
end
