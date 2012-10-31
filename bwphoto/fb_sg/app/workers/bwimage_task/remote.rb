module BwimageTask
  class Remote
    @queue = :remote

    def self.perform(id, url)
      bwimage = Bwimage.find(id)
      bwimage.remote_photo_url = url
      bwimage.save
      bwimage.recreate_delayed_versions!
    end
  end
end
