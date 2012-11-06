require 'rubygems'
require "bundler/setup"

require_relative '../../app.rb'

Bundler.require(:default)

require 'capybara/cucumber'

app = Rack::Builder.new do
	use Faye::RackAdapter, 	:mount => '/faye'
	use Rack::Static, :urls => ["/app"]
	run RackApp
end

Capybara.app = app
Capybara.server_port = 9292
Capybara.default_driver = :poltergeist
