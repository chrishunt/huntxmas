namespace :migration do
  desc 'Migrate all emails in the Users table to lowercase'
  task email: :environment do
    ActiveRecord::Base.connection.execute 'update users set email = lower(email)'
  end
end
