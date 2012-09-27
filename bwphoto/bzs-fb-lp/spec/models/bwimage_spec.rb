require 'spec_helper'

describe Bwimage do

  describe 'handlig input' do

    before do
      ResqueSpec.reset!
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
      bw = Bwimage.create!(:title => 'title',  
                      :url => 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg', 
                      :filename => 'some_file.png')

      bw.should_receive(:queue_task)
      bw.status.should == "queued"
    end

    it 'should create a file from base64 data and have status file_downloaded afterwards' do
      bw = Bwimage.create!(:title => 'title',  
                      :file => Base64.encode64(File.read(File.join(Rails.root, "spec", "fixtures", "image.jpg"))), 
                      :filename => 'some_file.png')
      
      bw.image.should be_exists
      bw.status.should == "file_downloaded"
    end

    it 'should download the image if url is present abd have status file_downloaded afterwards' do
      bw = Bwimage.create!(:title => 'title',  
                      :url => 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg', 
                      :filename => 'some_file.png')

      bw.image.should be_exists
      bw.status.should == "file_downloaded"
    end

    it 'should crop and grayscale the image and have a processed status afterwards' do
      bw = Bwimage.create!(:title => 'title',  
                      :file => Base64.encode64(File.read(File.join(Rails.root, "spec", "fixtures", "image.jpg"))), 
                      :filename => 'some_file.png')

      bw.crop_and_grayscale
      bw.status.should == "processed"
      Base64.encode64(bw.image).should == Base64.encode64(File.read(File.join(Rails.root, "spec", "fixtures", "processed_image.jpg")))
    end

    it 'should note if file is missing on url' do
      bw = Bwimage.create!(:title => 'title',  
                      :url => 'http://unexistent.com/8319/7992673887_a882d4e269_c.jpg', 
                      :filename => 'some_file.png')

      bw.image.should_not be_exists
      bw.status.should == "download_failed"
    end

    it 'should note if processing failed' do
      bw = Bwimage.create!(:title => 'title',  
                      :file => Base64.encode64(File.read(File.join(Rails.root, "spec", "fixtures", "unexistent.jpg"))), 
                      :filename => 'some_file.png')

      Bwimage.should have_queued(bw.id, :crop_and_grayscale)
      Bwimage.should have_queue_size_of(1)
      bw.status.should == "processing_failed"
    end

  end # handling input

end
