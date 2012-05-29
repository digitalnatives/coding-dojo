require 'rack'
require 'json'
class RackApp
  def self.call(env)
    @request = Rack::Request.new(env)
    @path_info = @request.path_info
    [200, {'Content-Type'=> route['Content-Type']}, [route['Body']] ]

    var do |a|
      puts 'asd'
    end
  rescue
    [404, {'Content-Type'=> 'text/plain'}, ['user'] ]
  end
  
  def post(&block)
    if @request.method == 'POST'
      block.call 
    end
    self
  end
  def get(&block)
    if @request.method == 'GET'
      block.call 
    end
    self
  end
  
  def var(&block)
    if @path_info =~ /\/(.*)\/?/
      block.call $1
    end
  end
end
