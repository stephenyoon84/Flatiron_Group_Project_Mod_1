# Setting up the application
require 'bundler/setup'

Bundler.require

require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/cocktail.db"
)

require_all 'app'
require 'json'
require 'rake'
load './Rakefile'
