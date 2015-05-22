require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "populate the database with dummy data"
task "db:populate" do
  User.create(username: 'Jody', email: 'jody@gmail.com', password: 'pass')
  User.create(username: 'Raymond', email: 'raymond@gmail.com', password: 'ray')
  User.create(username: 'Matt', email: 'matt@gmail.com', password: 'matt')
  User.create(username: 'Monica', eamil: 'monica@gmail.com', password: 'monica')
end
