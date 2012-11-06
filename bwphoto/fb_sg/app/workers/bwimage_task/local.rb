module BwimageTask
  class Local
    @queue = :local

    def self.perform(id)
      bwimage = Bwimage.find(id)
      bwimage.process!
    end
  end
end
