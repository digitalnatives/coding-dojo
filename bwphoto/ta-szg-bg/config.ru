require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require './app'

class HelloWorld
  def self.call(env)
  	puts env
    return [200, {}, ["Hello world!"]]
  end
end

run HelloWorld