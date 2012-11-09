require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require './app'

module Rack
  class Lint
    def call(env = nil)
      @app.call(env)
    end
  end
end

app = Rack::Builder.new do
	use Rack::Static, :urls => ["/app"]
	run RackApp
end

run app
