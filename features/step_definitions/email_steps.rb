Then /^(\d+) emails should have been sent$/ do |number|
  ActionMailer::Base.deliveries.count.to_s.should == number
end
