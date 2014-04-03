require 'sprockets'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'javascripts'
  environment.append_path 'stylesheets'
  run environment
end

map '/' do
  run Rack::Directory.new("static")
end
