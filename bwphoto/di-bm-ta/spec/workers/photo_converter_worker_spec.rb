require 'spec_helper'

describe PhotoConverterWorker do

  context "new job" do
    before :each do
      # TODO: mock photo here
    end

    it "should instantiate photo object" do
      Photo.should_receive( :find ).with( 1 ).and_return( FactoryGirl.create(:photo, :url) )

      @work = PhotoConverterWorker.new
      @work.perform(1)
    end

    context "with url" do
      it "should download the photo" do
        @work.should_receive( :download )
      end
      
      context "when downloading the photo" do
        it "should call some http library" do
          Curl::Easy.should_receive( :get )
        end
      end
    end

    context "with base64" do
      it "shouldn't download the photo" do
        @work.should_not_receive( :download )
      end
    end
    
    context "when converting a photo" do
      it "should call converter method" do
        @work.should_receive( :convert )
      end
    end
    
  end
end
