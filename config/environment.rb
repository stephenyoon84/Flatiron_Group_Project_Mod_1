# Setting up the application
require 'bundler/setup'

Bundler.require

require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/cocktail.db"
)

# ActiveRecord::Base.logger = Logger.new(STDOUT)

# connection_details = YAML::load(File.open('config/database.yml'))
#
# # DBRegistry[ENV["ACTIVE_RECORD_ENV"]].connect!
# DB = ActiveRecord::Base.establish_connection(connection_details)


require_all 'app'
require 'json'
