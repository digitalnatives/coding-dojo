require 'spec_helper'

describe PhotoConverterWorker do

  context "new job" do
    before :each do
      @work = PhotoConverterWorker.new
    end

    after :each do
      @work.perform(1)
      # TODO: mock xphoto here
    end

    it "should instantiate photo object" do
      Photo.should_receive( :find ).with( 1 ).and_return( FactoryGirl.create(:photo, :url) )
    end
  end

  context "with url" do
    before :each do
      @photo = FactoryGirl.create :photo, :url
      @job = PhotoConverterWorker.jobs.first
      @work = @job['class'].new
    end

    after :each do
      @work.perform(*@job['args'])
      # TODO: mock xphoto here
    end

    it "should download the photo" do
      @work.should_receive( :download )
    end

    it "should call some http library" do
      @work.should_receive( :open )
    end

    it "should call converter method" do
      @work.should_receive( :convert )
    end
  end

  context "with base64" do
    before :each do
      @photo = FactoryGirl.create :photo, :base64
      @job = PhotoConverterWorker.jobs.first
      @work = @job['class'].new
    end

    after :each do
      @work.perform(*@job['args'])
      # TODO: mock xphoto here
    end

    it "shouldn't download the photo" do
      @work.should_not_receive( :download )
    end

    it "should call converter method" do
      @work.should_receive( :convert )
    end
  end

end
