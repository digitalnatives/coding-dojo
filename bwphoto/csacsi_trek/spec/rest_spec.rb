require 'spec_helper'
require 'dm-serializer/to_json'

describe BWPhoto::Rest do

  let( :app ) { BWPhoto::Rest }

  describe "index" do
    it "should be successful" do
      get '/'
      last_response.should be_ok
    end
  end

  describe "show" do
    context "with existing photo" do
      subject { Photo.create }
      it 'should be successful' do
        get "/#{subject.id}"
        last_response.should be_ok
      end
    end
    it "with not existing photo" do
      get "/123456789"
      last_response.should be_error
    end
  end

  describe "destroy" do
    it 'should be successful' do
      delete '/1'
      last_response.should be_ok
    end
  end

  describe "create" do
    describe "with succes" do
      context 'using image url' do
       let( :params ) {{ photo: {
         :photo_url => 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg',
         :title => 'Title 1',
         :camera => 'Cannon EOS',
         :date => '2012-09-19',
         :author => 'Csacsi'
       }.to_json }}

        it 'should be successful' do
          post '/', params
          last_response.should be_ok
        end

        it 'should create a new Photo' do
          lambda {
            post '/', params
          }.should change( Photo.count ).by( 1 )
        end
      end

      context 'using image file' do
        let( :params ) {{ photo: {
          :photo => 'R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==',
          :photo_file_name => 'small.gif',
          :photo_content_type => 'image/gif',
          :title => 'Title 1',
          :camera => 'Cannon EOS',
          :date => '2012-09-19',
          :author => 'Andris'
        }.to_json }}

        it 'should be successful' do
          post '/', params
          last_response.should be_ok
        end

        it 'should create a new Photo' do
          lambda {
            post '/', params
          }.should change( Photo.count ).by( 1 )
        end
      end

      it 'should create a Sidekiq task' do
        pending #Sidekiq
      end
    end
    describe "with faliure" do
      let( :params ) {{ photo: {
         :photo_url => '',
         :title => 'Title 1',
         :camera => 'Cannon EOS',
         :date => '2012-09-19',
         :author => 'Csacsi'
       }.to_json }}
      it 'should be failed' do
          post '/', params
          last_response.should be_error
      end

      it 'should not create a new Photo' do
          lambda {
            post '/', params
          }.should_not change( Photo.count )
      end
    end
  end

end
