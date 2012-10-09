ENV["RACK_ENV"] ||= "development"

require 'bundler'
Bundler.setup

Bundler.require(:default, ENV["RACK_ENV"].to_sym)
$redis = Redis.connect
DataMapper.setup(:default, ENV["DATABASE_URL"] || "postgres://postgres:postgres@localhost/bwphoto_development" )

Dir["./lib/**/*.rb"].each { |f| require f }

