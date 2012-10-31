module BwimageTask
  class Local 
    @queue = :local

    def self.perform(id)
      bwimage = Bwimage.find(id)
      bwimage.recreate_delayed_versions!
    end
  end
end
