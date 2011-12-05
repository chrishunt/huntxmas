def in_memory_db?
  Rails.env == 'test' &&
    ( ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLiteAdapter ||
      ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLite3Adapter ) &&
  Rails.configuration.database_configuration['test']['database'] == ':memory:'
end

if in_memory_db?
  puts "Loading in-memory db..."
  load "#{Rails.root}/db/schema.rb"
end
