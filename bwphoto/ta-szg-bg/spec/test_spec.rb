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
	it "upload" do
		initial_count = Image.count
		response = request("/image", {title:"title", camera:"camera", date:"date",
		 author:"author,", picture:"picture", filename:"filename" }, "PUT")
		(Image.count - initial_count).should eq(1)
		response[:errors].count.should eq(0)
		response[:status].should eq(200)
	end

	it "should return error for missing title parameter" do
		initial_count = Image.count
		response = request("/image", {camera:"camera", date:"date", author:"author",
		 picture:"picture", filename:"filename" }, "PUT")
		(Image.count - initial_count).should eq(0)
		response[:errors][:title].should eq("")
		response[:status].should eq(500)
	end

	it "should return error for missing filename parameter" do
		initial_count = Image.count
		response = request("/image", {title:"title", camera:"camera", date:"date", author:"author",
		 picture:"picture"}, "PUT")
		(Image.count - initial_count).should eq(0)
		response[:errors][:filename].should eq("")
		response[:status].should eq(500)
	end

	it "should return error for wrong filename" do
		initial_count = Image.count
		response = request("/image", {title:"title", camera:"camera", date:"date", author:"author",
		 picture:"picture", filename:"filename" }, "PUT")
		(Image.count - initial_count).should eq(0)
		#hibaüzenetet kitölteni
		response[:errors][:filename].should eq("")
		response[:status].should eq(500)
	end
end