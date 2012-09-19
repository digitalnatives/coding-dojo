require 'spec_helper'

describe Bwimage do

  describe 'handlig input' do

    before do
      @bwimage = Bwimage.new
      @url_image = nil
      open('http://image_adress.com/image.jpg') do |file|
        image = MiniMagick::Image.from_blob(file.read) rescue nil
      end
    end

    it "should handle image from url" do
      @bwimage.from_url("http://example.com/image.jpg")
      
      @bwimage.url.should_not be_empty

    end

  end # handling input

end
