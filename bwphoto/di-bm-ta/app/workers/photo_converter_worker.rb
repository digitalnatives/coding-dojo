require 'open-uri'

class PhotoConverterWorker
  include Sidekiq::Worker

  def perform(photo_id)
    @photo = Photo.find(photo_id)
    
    download if @photo.url.present?
    convert

    @photo.update_attribute(:status, "processed")
  end

  def download
    @photo.photo = open(@photo.url).read
  end

  def convert

  end

end