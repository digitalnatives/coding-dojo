Faye::WebSocket.load_adapter('thin')

module Rack
  class Lint
    def call(env = nil)
      @app.call(env)
    end
  end
end

class FayeRack < Faye::RackAdapter
  def initialize(app = nil, options = nil)
    super app, options
    $faye_client = Faye::Client.new(@server)
  end

  def get_client
    $faye_client
  end
end

