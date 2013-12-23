source 'http://rubygems.org'
ruby '2.0.0'

gem 'rails',        '4.0.2'

gem 'bcrypt-ruby',  '~> 3.1.2'
gem 'haml',         '~> 4.0.4'
gem 'jquery-rails', '~> 3.0.4'
gem 'pg',           '~> 0.17.1'
gem 'rspec',        '~> 2.14.1'
gem 'sidekiq',      '~> 2.17.1'
gem 'unicorn',      '~> 4.7.0'

# Assets
gem 'coffee-rails', '~> 4.0.1'
gem 'sass-rails',   '~> 4.0.1'
gem 'uglifier',     '~> 2.4.0'

group :test do
  gem 'capybara',           '~> 2.2.0'
  gem 'cucumber-rails',     '~> 1.4.0', require: false
  gem 'database_cleaner',   '~> 1.2.0'
  gem 'factory_girl_rails', '~> 4.3.0'
  gem 'rspec-rails',        '~> 2.14.0'
  gem 'turn',               '~> 0.9.6', require: false
end

group :development, :test do
  gem 'pry', '0.9.12.4'
end

group :production do
  gem 'exception_notification', '4.0.1'
  gem 'rails_12factor',         '0.0.2'
end
