require 'rubygems'
require "bundler/setup"

require_relative '../../app.rb'

Bundler.require(:default)

require 'capybara/cucumber'

Capybara.app = RackApp
Capybara.default_driver = :poltergeist
