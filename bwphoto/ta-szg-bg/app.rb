require 'rack'
require 'json'
require 'rubygems'
require 'datamapper'
require 'sinatra'

DataMapper.setup(:default, :adapter => 'in_memory')

class Image
  include Datamapper::Resource

  property :id, Serial
  property :title, Text
  property :camera, Text
  property :date, DateTime
  property :author, Text
  property :picture, Text
  property :filename, Text

end

DataMapper.finalize

class RackApp < Sinatra::Application
end
