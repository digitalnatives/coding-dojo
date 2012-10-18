ENV["RACK_ENV"] ||= "development"

require 'bundler'
Bundler.setup
require 'data_mapper'

Bundler.require(:default, ENV["RACK_ENV"].to_sym)
$redis = Redis.connect
DataMapper.setup(:default, ENV["DATABASE_URL"] || "postgres://postgres:postgres@localhost/bwphoto_development" )
DataMapper::Model.send(:include, ::CarrierWave::Backgrounder::ORM::Base)

Dir["./lib/**/*.rb"].each { |f| require f }
CarrierWave::Backgrounder.configure do |c|
  # :delayed_job, :girl_friday, :sidekiq, :qu, :resque, or :qc
  c.backend = :sidekiq
end
