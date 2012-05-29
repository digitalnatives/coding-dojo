require_relative "../../router"
 
require 'capybara'
require 'capybara/cucumber'
#require 'rspec'
#require 'rack/test'
 
#World do
  Capybara.app = Router
 
  #include Capybara::DSL
  #include RSpec::Matchers
#end