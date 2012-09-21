require 'spec_helper'

describe BWPhoto::Rest do

  def app
    @app ||= BWPhoto::Rest
  end

  describe "index" do
    it "should be successful" do
      get '/'
      last_response.should be_ok
    end
  end

  describe "show" do
    it 'should be successful' do
      get '/1'
      last_response.should be_ok
    end
  end

  describe "destroy" do
    it 'should be successful' do
      delete '/1'
      last_response.should be_ok
    end
  end

  describe "create" do
    context 'using image url' do
      let( :params ) {{
        :photo_url => 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg',
        :title => 'Title 1',
        :camera => 'Cannon EOS',
        :date => '2012-09-19',
        :author => 'Csacsi'
      }}

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
      let( :params ) {{
        :photo => 'R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==',
        :photo_file_name => 'small.gif',
        :photo_content_type => 'image/gif',
        :title => 'Title 1',
        :camera => 'Cannon EOS',
        :date => '2012-09-19',
        :author => 'Andris'
      }}

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
      Sidekiq
    end
  end

end