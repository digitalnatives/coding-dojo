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

    it 'should create a valid bwimage' do
      Bwimage.create!(:title => 'title',  
                      :url => 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg', 
                      :filename => 'some_file.png')
      .should be_valid

      Bwimage.create!(:title => 'title',  
                      :file => Base64.encode64(File.read(File.join(Rails.root, "spec", "fixtures", "image.jpg"))), 
                      :filename => 'some_file.png')
      .should be_valid
    end

    it 'should create a new worker after create and have status queued' do
      Bwimage.create!(:title => 'title',  
                      :url => 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg', 
                      :filename => 'some_file.png')
    end

    it 'should create a file from base64 data and have status file_downloaded afterwards' do
    end

    it 'should download the image if url is present abd have status file_downloaded afterwards' do
    end

    it 'should crop and grayscale the image and have a processed status afterwards' do
    end

  end # handling input



end
