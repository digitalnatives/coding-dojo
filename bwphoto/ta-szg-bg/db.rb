require "base64"

DataMapper.setup(:default, 'yaml:db')

class Picture
  include DataMapper::Resource

  property :id,       Serial
  property :title,    Text,       :required => true
  property :camera,   Text
  property :date,     Text
  property :author,   Text
  property :picture,  Text,        :lazy => false
  property :processed_picture, Text
  property :filename, Text,       :required => true,:lazy => false
  property :status,   Text,       :default => 'queued'

end

class Worker
  include Sidekiq::Worker
	def perform(id)
    Worker.perform_async id
	end
	def self.convert(id)
    img = Picture.get(id)
    content = img.picture
    unless content
      content = Base64.encode64(Curl::Easy.perform(img.filename).body_str)
    end
    if content
      image = Magick::Image.read_inline(content).first
      image.crop_resized!(100,100)
      image.quantize(256,Magick::GRAYColorspace)
      img.update({
        processed_picture: Base64.encode64(image.to_blob),
        status: 'processed'
      })
      img.save
    end
	end
end

DataMapper.finalize