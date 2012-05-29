require 'rack'
require 'json'
require 'rubygems'
require 'datamapper'

DataMapper.setup(:default, :adapter => 'in_memory')

class User
  include DataMapper::Resource

  property :id,         Integer, :key => true, :unique => true
  property :name,       String

  has n, :comments

  def [](sym)
    self.send sym
  end
end

class Comment
  include DataMapper::Resource

  property :id,            Integer, :key => true, :unique => true
  property :message,       String

  belongs_to :user

  def [](sym)
    self.send sym
  end
end

DataMapper.finalize

class Router

  def initialize(path_info,request)
    @path_info = path_info
    @request = request
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
  
  def part(name, &block)
    if @path_info =~ /\/(.*?)(?=(?:\/|$))/
      if $1 == name
        p = $1.dup
        @path_info.sub! /(\/.*?)(?=(?:\/|$))/, ''
        block.call p
      end
    end
  end

  def var(&block)
    if @path_info =~ /\/(.*?)(?=(?:\/|$))/
      p = $1.dup
      @path_info.sub! /(\/.*?)(?=(?:\/|$))/, ''
      block.call p
    end
  end

end

class RackApp
  def self.call(env)
    @request = Rack::Request.new(env)
    @path_info = @request.path_info

    r = Router.new @path_info, @request
    r.instance_eval do
      part 'users' do
        var do |id|
          return [200, {'Content-Type'=> 'text/json'}, [User.first(:id => id).to_json]]
        end
      end
    end
    [200, {'Content-Type'=> 'text/json'}, ['']]
  rescue => e
    puts e
    [404, {'Content-Type'=> 'text/plain'}, ['not found'] ]
  end
  
end
