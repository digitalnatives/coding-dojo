require 'spec_helper'

describe PhotoConverterWorker do

  context "new job with url" do
    before :each do
      @photo = FactoryGirl.build(:photo, :url).should be_valid
    end

    it "should download and save the photo" do
    end
  end

  context "new job" do
    it "should reprocess the photo" do
      @photo.photo
    end
  end

end
