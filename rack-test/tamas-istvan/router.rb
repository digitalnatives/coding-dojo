require 'rubygems'
require 'rack'

class Router
  def call(env)
    [200, {"Content-Type" => "text/html"}, "Hello Rack!"]
  end
end