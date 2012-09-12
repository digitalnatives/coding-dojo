ENV['RACK_ENV'] = 'test'
# require File.expand_path(File.dirname(__FILE__) + "/../../init")
 
require 'capybara'
require 'capybara/cucumber'
require 'rspec/mocks'
require 'cucumber/rspec/doubles'
require './rack_app'
 
Capybara.app = RackApp
