module BwimageTask
  class Remote
    @queue = :remote

    def self.perform(id, url)
      bwimage = Bwimage.find(id)
      bwimage.remote_photo_url = url
      unless bwimage.save
        bwimage.remote_photo_url = nil
        bwimage.fail!
      else
        bwimage.download!
        bwimage.process!
      end
    end
  end
end
