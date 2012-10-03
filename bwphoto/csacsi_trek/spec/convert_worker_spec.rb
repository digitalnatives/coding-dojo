require 'spec_helper'

class ConvertWorker; end
describe ConvertWorker do

  subject { ConvertWorker.new }
  let( :tmp_path ) { '/tmp/asdf' }
  let( :destination ) { '/tmp/asdff' }

  context '#perform' do
    it 'should convert the image to grayscale' do
      # Grayscale: mogrify -type Grayscale input-picture.png
      subject.should_receive( :system ).with( 'mogrify', '-type', 'Grayscale', tmp_path )
      subject.perform( tmp_path, destination )
    end

    it 'should resize and crop the image' do
      # Grayscale: mogrify -resize 100x100 input-picture.png
      subject.should_receive( :system ).with( 'mogrify', '-resize', '100x100', tmp_path )
      subject.perform( tmp_path, destination )
    end
  end
end
