require 'spec_helper'

describe Photo do

  describe "before create" do
    context "image via url" do
      before( :each ) do
        @photo = FactoryGirl.build(:photo, :url)
      end

      it "should be valid" do
        @photo.should be_valid
      end

      it "should be fetch from url" do
        @photo.save
        @photo.photo_file_name.should_not be_blank
      end
    end

    context "image via base64" do
      before( :each ) do
        @photo = FactoryGirl.build(:photo, :base64)
      end

      it "should be valid" do
        @photo.should be_valid
      end

      it "should be saved to a file" do
        @photo.save
        @photo.photo_file_name.should_not be_blank
      end
    end
  end

  describe "after create" do
    before :each do
      @photo = FactoryGirl.create :photo, :url
    end

    context "before process" do
      it "it's status should be queued" do
        @photo.status.should == 'queued'
      end

      it "should create a background worker" do
        PhotoConverterWorker.jobs.size.should == 1
      end
    end

    context "after process" do
      before :each do
        PhotoConverterWorker.drain
      end

      it "it's status should be processed" do
        @photo.reload.status.should == 'processed'
      end

      it "shouldn't be any background job" do
        PhotoConverterWorker.jobs.size.should == 1
      end
    end
  end
end
