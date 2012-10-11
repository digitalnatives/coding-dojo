require 'open-uri'

class PhotoConverterWorker
  include Sidekiq::Worker

  def perform(photo_id)
    @photo = Photo.find(photo_id)
    download(photo_id) if @photo.url.present?
    convert(photo_id)
  end

  def download(photo_id)
    @photo.photo = open(@photo.url).read
  end

  def convert(photo_id)

  end

end