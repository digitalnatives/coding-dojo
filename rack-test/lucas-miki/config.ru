require 'rack'
require 'json'
require './rack_app'

use Rack::Reloader

run RackApp