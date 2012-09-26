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
  it "should upload base64" do
    initial_count = Image.count
    response = request("/image", {title:"title", camera:"camera", date:"date",
     author:"author,", picture:"picture", filename:"filename" }, "PUT")
    (Image.count - initial_count).should eq(1)
    response[:errors].count.should eq(0)
    response[:status].should eq(200)
  end

  it "should upload url" do
    initial_count = Image.count
    response = request("/image", {title:"title", camera:"camera", date:"date",
     author:"author,", filename:"filename" }, "PUT")
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
      filename:"filename" }, "PUT")
    (Image.count - initial_count).should eq(0)
    #hibaüzenetet kitölteni
    response[:errors][:filename].should eq("")
    response[:status].should eq(500)
  end

  it "should return error for wrong base64" do
    initial_count = Image.count
    response = request("/image", {title:"title", camera:"camera", date:"date", author:"author",
     picture:"picture", filename:"filename" }, "PUT")
    (Image.count - initial_count).should eq(0)
    #hibaüzenetet kitölteni
    response[:errors][:picture].should eq("")
    response[:status].should eq(500)
  end

end

describe "Model" do

  it 'convert should call Worker convert method' do
    img = Image.new({picture: 'base64'})
    Worker.should_recieve(:convert).with(img.id, 'base64')
    img.convert
  end

  it 'status should be queued on creation' do
    img = Image.new
    img.status.should eq('queued')
  end

  it 'status should be processed after conversion' do
    img = Image.new({picture: 'base64'})
    Worker.should_recieve(:convert).with(img.id, 'base64')
    img.convert do
      igm.status.should eq('processed')
    end
  end

end


describe "Worker" do
  it 'should fetch image if url given' do
    img = Image.new({filename: '/blahblah.png'})
    HTTP.should_recieve(:get).with('/blahblah.png')
    Worker.convert img.id, '/blahblah.png'
  end

  it 'should call imagemagick' do
    img = Image.new({filename: '/blahblah.png'})
    ImageMagick.should_recieve(:convert).with()
    Worker.convert img.id, '/blahblah.png'
  end
end