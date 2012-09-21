require 'spec_helper'

describe Api::BwimageController do

describe "GET 'upload'" do

  describe 'base64' do

    before do
      @file = File.open(File.join(Rails.root, "spec", "fixtures", "image.jpg"))
    end

    it 'should upload image with valid data' do
      attrs = { :file => @file }
      post 'upload', attrs

    end

  end # base64
  
    it "returns http success" do
      attrs = {   }
      post 'upload'
      response.should be_success
    end

  end # GET upload

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'delete'" do
    it "returns http success" do
      get 'delete'
      response.should be_success
    end
  end

end
