FactoryGirl.define do
  factory :gift do
    name 'car'
    url  'http://google.com'
    user
  end

  factory :user do
    sequence(:name)  { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@domain.com" }
    password 'secret'
  end
end
