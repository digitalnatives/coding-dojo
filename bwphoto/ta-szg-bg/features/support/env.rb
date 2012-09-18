require 'rubygems'
require "bundler/setup"

load './features/support/app.rb'

Bundler.require(:default)

require 'capybara/cucumber'

Capybara.app = RackApp
#Capybara.default_driver = :poltergeist
