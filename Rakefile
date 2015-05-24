require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)
require_relative 'lib/users_importer'
require_relative 'lib/plusones_importer'
require_relative 'lib/activities_importer'
require_relative 'lib/cohorts_importer'
require_relative 'lib/enrollments_importer'

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  if ENV['RACK_ENV'] == 'production'
    create schema allTables
  else
    touch 'db/db.sqlite3'
  end
end

desc "drop the database"
task "db:drop" do
  if ENV['RACK_ENV'] == 'production'
    drop schema allTables cascade
  else
    rm_f 'db/db.sqlite3'
  end
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "populate the test database with sample data"
task "db:populate" do
  # UsersImporter.new.import
  # PlusonesImporter.new.import
  # ActivitiesImporter.new.import
  CohortsImporter.new.import
  # EnrollmentsImporter.new.import
end
