require_relative '../../../app/workers/bwimage_task/remote.rb'

class Bwimage
end

describe BwimageTask::Remote do

  describe 'perform' do
    
    let(:bwimage) { stub.as_null_object }

    it 'should find image' do
      Bwimage.should_receive(:find).and_return(bwimage)
      BwimageTask::Remote.perform(1, "http://example.com/image.jpg")
    end

    it 'should get url' do
      Bwimage.stub(:find) { bwimage }
      bwimage.should_receive(:remote_photo_url=).with("http://example.com/image.jpg")
      BwimageTask::Remote.perform(1, "http://example.com/image.jpg")
    end

    it 'should change status' do
      Bwimage.stub(:find) { bwimage }
      bwimage.should_receive(:download!)
      BwimageTask::Remote.perform(1, "http://example.com/image.jpg")
    end
    
  end # perform

end
