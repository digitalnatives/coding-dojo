require 'rubygems'
require 'rack'

class Router
  def self.call(env)
    [200, {"Content-Type" => "text/html"}, "Hello Rack!"]
  end
end