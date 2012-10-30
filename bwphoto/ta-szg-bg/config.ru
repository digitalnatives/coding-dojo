require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require './app'


app = Rack::Builder.new do
	use Faye::RackAdapter, 	:mount => '/faye'
	use Rack::Static, :urls => ["/app"]
	run RackApp
end

run app
