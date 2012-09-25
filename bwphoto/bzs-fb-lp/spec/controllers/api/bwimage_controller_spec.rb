require 'spec_helper'

describe Api::BwimageController do

describe "GET 'upload'" do

  describe 'base64' do

    def valid_params
      f = File.read(File.join(Rails.root, "spec", "fixtures", "image.jpg"))
      {
        :file => Base64.encode64(f),
        :title => 'Image'
      }
    end

    describe 'success' do

      it 'should upload image with valid data' do
        post 'upload', valid_params 

      end

    end

    describe 'fail' do

      it 'should have invalid base64 data' do
      end
      it 'missing title data' do
          attrs = valid_params
          attrs[:title] = nil
          post :upload, attrs

          assigns(:bwimage).should_not be_valid
          assigns(response.body).should contain('error')
      end

    end

  end # base64

  describe 'http' do

    def valid_params
      {
        :url => 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg',
        :title => 'Image'
      }
    end

    describe 'success' do
      it "returns http success" do
        post 'upload', valid_params
        response.should be_success
      end
    end

    describe 'fail' do

        it 'has no url' do
          attrs = valid_params
          attrs[:url] = nil
          post :upload, attrs

          assigns(:bwimage).should_not be_valid
          assigns(:bwimage).errors.should contain(:url)
        end

        it 'has no title' do
          attrs = valid_params
          attrs[:title] = nil
          post :upload, attrs

          assigns(:bwimage).should_not be_valid
          assigns(response.body).should contain('error')
        end

    end

  end # http

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
