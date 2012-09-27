require 'spec_helper'

describe Photo do
  it "should be valid" do
    FactoryGirl.build(:photo).should be_valid
  end

  describe "after creation" do
    context "url" do

      before :each do
        @photo = FactoryGirl.create :photo, :url
      end


      it "it's status should be queued" do
        @photo.status.should == 'queued'
      end

      it "should create a background worker" do
        PhotoConverterWorker.jobs.size.should == 1
      end

      describe "processed" do
        before :all do
          PhotoConverterWorker.drain
        end

        it "it's status should be processed" do
          @photo.reload.status.should == 'processed'
        end

        it "should have bw file" do
        end
      end
    end

  end

end
