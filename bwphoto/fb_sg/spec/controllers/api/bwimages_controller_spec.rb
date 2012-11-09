require 'spec_helper'

describe Api::BwimagesController do

  describe 'create' do

    let(:file) { Base64.encode64(File.read(File.join(Rails.root, "spec", "fixtures", "image.jpg"))) }

    context 'when object valid' do

      context 'receiving base64' do

        it 'should respond with success' do 
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
          assigns(:bwimage).reload
          assigns(:bwimage).author.should == "John Doe"
          assigns(:bwimage).status.should == "finished"
          response.should be_success
        end

      end

      context 'receiving url' do

        context 'that exists' do

          it 'respond with success' do
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

        end

        context 'that not exists' do

          it 'respond with success' do
            image = {
              title: "Picture title",
              author: "John Doe",
              camera: "Nikon",
              taken_at: Time.now - 2.days,
              url: "http://farm9.staticflickrrrr.com/8319/7992673887_a882d4e269_c.jpg"
            }

            post :create, { :bwimage => image.to_json, :format => :json }

            assigns(:bwimage).reload
            assigns(:bwimage).should be_download_failed
            response.should be_success 
          end

        end
       
      end # receiving url

    end # object valid

    describe 'fail' do

      it 'base64' do
        image = {
          file: file,
        }

        post :create, { :bwimage => image.to_json, :format => :json }

        assigns(:bwimage).errors.should include(:title)
        response.should_not be_success 
      end

      it 'invalid' do
        image = {
          author: "John Doe",
          camera: "Nikon",
          taken_at: Time.now - 2.days,
          url: "http://farm9.staticflickrrrr.com/8319/7992673887_a882d4e269_c.jpg"
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
