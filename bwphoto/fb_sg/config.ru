# This file is used by Rack-based servers to start the application.
require 'faye'

require ::File.expand_path('../config/environment',  __FILE__)
require ::File.expand_path('../config/faye_setup',  __FILE__)

use FayeRack, { :mount => '/faye', :timeout => 25 }
run RailsCarrierwave::Application
