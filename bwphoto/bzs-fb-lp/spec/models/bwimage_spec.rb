require 'spec_helper'
require 'sidekiq/testing'

describe Bwimage do

  describe 'handlig input' do

    before do
      ResqueSpec.reset!
    end

    describe 'base64' do

      let(:bw) {
        bwimage = Bwimage.create!(:title => 'title',
                        :file => Base64.encode64(File.read(File.join(Rails.root, "spec", "fixtures", "image.jpg"))), 
                        :filename => 'some_file.png',
                        :content_type => 'image/png')
      }

      it 'should create a valid bwimage' do
        Bwimage.create!(:title => 'title',  
                        :file => Base64.encode64(File.read(File.join(Rails.root, "spec", "fixtures", "image.jpg"))), 
                        :filename => 'some_file.png',
                        :content_type => 'image/png')
        .should be_valid
      end

      it 'should create a file from base64 data and have status file_downloaded afterwards' do
        bw.image.should be_exists
        bw.status.should == "file_downloaded"
      end

      it 'should create a new workers after create (crop)' do
        expect {
          BwimageWorker.perform_async(bw)
        }.to change(BwimageWorker.jobs, :size).by(1)
      end

      it 'should crop and grayscale the image and have a processed status afterwards' do
        bw.crop_and_grayscale
        bw.status.should == "processed"
        #imagemagick compare?
        #Base64.encode64(bw.image).should == Base64.encode64(File.read(File.join(Rails.root, "spec", "fixtures", "processed_image.jpg")))
      end

      it 'should note if processing failed (becouse of missing file)' do
        #Bwimage.should have_queued(bw.id, :crop_and_grayscale)
        #Bwimage.should have_queue_size_of(1)
        bw.image.stub(:path) {"wrong path"}
        bw.crop_and_grayscale
        bw.status.should == "processing_failed"
      end

    end # base64

    describe 'url' do

      let(:bw) { 
        Bwimage.create!(:title => 'title',  
                        :url => 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg',
                        :filename => 'some_file.png',
                        :content_type => 'image/png')

      }

      it 'should create a valid bwimage' do
        bw.should be_valid
      end

      it 'should create a new workers after create (download, crop)' do
        expect {
          BwimageWorker.perform_async(bw)
        }.to change(BwimageWorker.jobs, :size).by(2)
      end


      it 'should download the image if url is present and have status file_downloaded afterwards' do
        bw.download_image_from_url
        bw.image.should be_exists
        bw.status.should == "file_downloaded"
      end


      it 'should note if file is missing on url' do
        bw = Bwimage.create!(:title => 'title',  
                        :url => 'http://valami123.hu',
                        :filename => 'some_file.png',
                        :content_type => 'image/png')
        bw.download_image_from_url
        bw.image.should_not be_exists
        bw.status.should == "download_failed"
      end

    end # url

  end # handling input

  describe 'validate attributes' do
    let(:bw) { 
      Bwimage.new(:title => 'title',  
                      :url => 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg',
                      :filename => 'some_file.png',
                      :content_type => 'image/png')

    }

    describe 'should have a valid url if present' do
      it 'should accept nil' do
        bw.url = nil
        bw.should be_valid
      end
      it 'should accept a valid url format' do
        bw.should be_valid
      end
      it 'should not accept invalid url format' do
        bw.url = 'htttp://com/8319/7992673887_a882d4e269_c.jpg'
      end
    end
  end


end
