require './router.rb'

use Rack::Reloader, 0
Rack::Handler::Thin.run Router.new, :Port => 3000
