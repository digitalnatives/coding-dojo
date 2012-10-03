class PhotoConverterWorker
  include Sidekiq::Worker

  def perform(photo_id)
    download(photo_id)
    convert(photo_id)
  end

  def download(photo_id)

  end

  def convert(photo_id)

  end

end