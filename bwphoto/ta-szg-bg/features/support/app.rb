require 'rack'
require 'json'
require 'rubygems'
require 'datamapper'
require 'sinatra'

DataMapper.setup(:default, :adapter => 'in_memory')
DataMapper.finalize

class RackApp < Sinatra::Application
end
