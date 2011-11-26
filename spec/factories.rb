FactoryGirl.define do
  factory :gift do
    name 'car'
    url  'http://google.com'
    user
  end

  factory :user do
    name  'user'
    email 'user@domain.com'
    password 'password'
  end
end
