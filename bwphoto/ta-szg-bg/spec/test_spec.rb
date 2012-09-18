require 'net/http'
require 'cgi'
require 'json'

def request(path, data, method)
	queryString = data.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
	response = Net::HTTP.get("localhost:9292","#{path}?".concat(queryString))
	JSON.parse response.to_s, {:symbolize_names => true}
end

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = :documentation
end

describe 'API' do
	it "should" do
		true.should eq(false)
	end
end