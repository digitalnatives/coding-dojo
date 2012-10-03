require 'spec_helper'

describe DownloadWorker do

  subject { DownloadWorker.new }
  let( :remote_url) { 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg' }
  let( :tmp_path ) { '/tmp/asdf' }
  let( :destination ) { '/tmp/asdff' }

  context '#perform' do
    it 'should download the image' do
      subject.should_receive( :system ).with( 'curl', '-o', tmp_path, remote_url )
      subject.perform( remote_url, tmp_path, destination )
    end

    it 'calls the convert worker after successfull download' do
      subject.stub :system => true
      ConvertWorker.should_receive( :perform_async ).with( tmp_path, destination )
      subject.perform( remote_url, tmp_path, destination )
    end

    it 'raise an exception if the download failed' do
      subject.stub :system => true
      expect {
        subject.perform( remote_url, tmp_path, destination )
      }.to raise_error( DownloadError )
    end

  end
end
