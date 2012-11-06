require 'spec_helper'

describe Api::BwimagesController do

  describe 'create' do

    let(:file) { Base64.encode64(File.read(File.join(Rails.root, "spec", "fixtures", "image.jpg"))) }

    describe 'success' do

      it 'base64' do
        image = {
          title: "Picture title",
          author: "John Doe",
          camera: "Nikon",
          taken_at: Time.now - 2.days,
          file: file,
          filename: "test_file.jpg"
        }

        post :create, { :bwimage => image.to_json, :format => :json }

        Base64.encode64(File.read(assigns(:bwimage).photo.path)).should == file
        assigns(:bwimage).author.should == "John Doe"
        response.should be_success
      end

      it 'url' do
        image = {
          title: "Picture title",
          author: "John Doe",
          camera: "Nikon",
          taken_at: Time.now - 2.days,
          url: "http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg"
        }

        post :create, { :bwimage => image.to_json, :format => :json }
        assigns(:bwimage).reload

        Base64.encode64(File.read(assigns(:bwimage).photo.path)).should == file
        response.should be_success
      end

    end # success

    describe 'fail' do

      it 'base64' do
        image = {
          file: file,
        }

        post :create, { :bwimage => image.to_json, :format => :json }

        assigns(:bwimage).errors.should include(:title)
        response.should_not be_success 
      end

      it 'url' do
        image = {
          url: "http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg"
        }

        post :create, { :bwimage => image.to_json, :format => :json }

        assigns(:bwimage).errors.should include(:title)
        response.should_not be_success 
      end

      it 'not json' do
        image = {
          url: "http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg"
        }

        post :create, { :bwimage => image, :format => :json }

        assigns(:bwimage).errors.should include(:title)
        response.should_not be_success 
      end

    end # fail

  end # create

end
