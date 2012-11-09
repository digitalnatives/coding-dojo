require 'open-uri'

class PhotoConverterWorker
  include Sidekiq::Worker

  def perform(photo_id)
    @photo = Photo.find(photo_id)

    download if @photo.url.present?

    @photo.update_attribute(:status, "processing")
    convert
    @photo.update_attribute(:status, "processed")
  end

  def download
    url = @photo.url
    extname = File.extname(url)
    basename = File.basename(url, extname)

    file = Tempfile.new([basename, extname])
    file.binmode

    open(URI.parse(url)) do |data|
      file.write data.read
    end

    file.rewind

    @photo.photo = file
  end

  def convert
    @photo.photo.reprocess!
  end

end