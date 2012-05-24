ENV['RACK_ENV'] = 'test'
# require File.expand_path(File.dirname(__FILE__) + "/../../init")
 
require 'capybara'
require 'capybara/cucumber'
require './rack_app'
 
Capybara.app = RackApp
