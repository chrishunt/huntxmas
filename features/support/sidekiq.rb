require 'sidekiq/testing'

AfterStep do
  Sidekiq::Worker.drain_all
end
