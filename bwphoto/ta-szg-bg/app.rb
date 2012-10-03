require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require './db'

class RackApp < Sinatra::Application
  get "/image" do
  end
  put "/image" do
    img = Picture.new(request.params)
    if img.save
      {status: 200, errors: []}.to_json
    else
      {status: 500, errors: img.errors}.to_json
    end
  end
end
