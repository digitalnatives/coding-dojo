# encoding: utf-8

require "rubygems"
require "bundler/setup"
Bundler.require(:default)
require 'sidekiq/testing'
require 'simplecov'
SimpleCov.command_name 'test:db'
SimpleCov.start


require './app'
Picture.all.destroy

$app = RackApp.new

SMURF_DATA = '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'

def request(path, data, method = 'GET')
  env = {
    'REQUEST_METHOD' => method,
    'QUERY_STRING'   => data.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"}.join("&"),
    "REQUEST_URI"    => path,
    "PATH_INFO"      => path,
    "HTTP_HOST"      => "localhost",
    "SERVER_PORT"    => "9292",
    "HTTPS"          => "off",
    "rack.input"     => StringIO.new("wtf")
  }
  resp = $app.call(env)
  json = JSON.parse resp[2].body[0], {:symbolize_names => true}
  json
end

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = :documentation
end

describe 'all' do

  describe 'Process' do
    it 'should convert base64' do
      initial_count = Picture.all.length
      response = request("/image", {title:"title", camera:"camera", date:"date",
       author:"author,", picture: SMURF_DATA, filename:"filename.png" }, "POST")
      (Picture.all.length - initial_count).should eq(1)
      response[:status].should eq(200)
      response[:errors].count.should eq(0)
    end
  end

  describe 'API' do
    it "should upload base64" do
      initial_count = Picture.all.length
      response = request("/image", {title:"title", camera:"camera", date:"date",
       author:"author", picture:"picture", filename:"filename.png" }, "POST")
      (Picture.all.length - initial_count).should eq(1)
      response[:errors].count.should eq(0)
      response[:status].should eq(200)
    end

    it "should upload url" do
      initial_count = Picture.all.length
      response = request("/image", {title:"title", camera:"camera", date:"date",
       author:"author,", filename:"filename.png" }, "POST")
      (Picture.all.length - initial_count).should eq(1)
      response[:errors].count.should eq(0)
      response[:status].should eq(200)
    end

    it "should return error for missing title parameter" do
      initial_count = Picture.all.length
      response = request("/image", {camera:"camera", date:"date", author:"author",
       picture:"picture", filename:"filename" }, "POST")
      (Picture.all.length - initial_count).should eq(0)
      response[:errors].include?("Title must not be blank").should eq(true)
      response[:status].should eq(500)
    end

    it "should return error for missing filename parameter" do
      initial_count = Picture.all.length
      response = request("/image", {title:"title", camera:"camera", date:"date", author:"author",
       picture:"picture"}, "POST")
      (Picture.all.length - initial_count).should eq(0)
      response[:errors].include?("Filename must not be blank").should eq(true)
      response[:status].should eq(500)
    end

    it "should return error for wrong filename" do
      initial_count = Picture.all.length
      response = request("/image", {title:"title", camera:"camera", date:"date", author:"author",
        filename:"filename" }, "POST")
      (Picture.all.length - initial_count).should eq(0)
      #hibaüzenetet kitölteni
      response[:errors].include?("Only images can be uploaded!").should eq(true)
      response[:status].should eq(500)
    end

    it "should return error for wrong base64" do
      initial_count = Picture.all.length
      response = request("/image", {title:"title", camera:"camera", date:"date", author:"author",
       picture:"éáőúóóüö", filename:"filename.png" }, "POST")
      (Picture.all.length - initial_count).should eq(0)
      response[:errors].include?("Wrong base64!").should eq(true)
      response[:status].should eq(500)
    end

    it 'should list all images' do
      initial_count = Picture.all.length
      response = request("/image", {}, "GET")
      (initial_count - response.count).should eq(0)
    end

    it 'should show an error where invalid image' do
      response = request("/image/99999999999",{},  "GET")
      response[:errors].include?('Invalid picture id!').should eq(true)
      response[:status].should eq(500)
    end

    it 'should show an error when showing unprocessed picture' do
      i = Picture.new(:picture => 'BASE64', :filename => 'filename.png', :title => 'title' )
      i.save
      response = request("/image/#{i.id}", {}, "GET")
      response[:errors].include?('Unprocessed picture!').should eq(true)
      response[:status].should eq(500)
    end

    it 'should show processed picture' do
      i = Picture.new(:processed_picture => 'BASE64' )
      response = request("/image/#{i.id}", {}, "GET")
      response.should_not eq(nil)
    end
  end

  describe "Model" do

    it 'status should be queued on creation' do
      img = Picture.new
      img.status.should eq('queued')
    end

    it 'status should be processed after conversion' do
      img = Picture.new({picture: SMURF_DATA, title: 'asd', filename: 'as.png'})
      img.save
      Worker.convert img.id
      Picture.get(img.id).status.should eq('processed')
    end

  end

  describe "Worker" do
    it 'should add job' do
      img = Picture.new({title: 'test', filename: 'asd.png'})
      expect {
        Worker.perform_async(img.id)
      }.to change(Worker.jobs, :size).by(1)
    end

    it 'should call imagemagick' do
      img = Picture.new({title: 'test', picture: SMURF_DATA, filename: 'filename.png'})
      img.save
      Magick::Image.should_receive(:read_inline).and_return [stub.as_null_object]
      Worker.convert img.id
    end

    class FakeResponse
      def body_str
        Base64.decode64(SMURF_DATA)
      end
    end

    it 'should download from url' do
      img = Picture.new({title: 'test', filename: 'http://bluebuddies.com/Smurf_Picture_and_Files/00002416/2012smurfs.jpg'})
      img.save
      Curl::Easy.should_receive(:perform).and_return FakeResponse.new
      Worker.convert img.id
    end
  end

end
