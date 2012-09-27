require 'spec_helper'

describe DownloadWorker do

  subject { DownloadWorker.new }
  let( :remote_url)
  let( :tmp_path ) { '/tmp/asdf' }
  let( )

  context '#perform' do
    it 'should download the image and convert it' do
      subject.should_receive( :system ).with( )
    end

    it 'should '


  end
end
