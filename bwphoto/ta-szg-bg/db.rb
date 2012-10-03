DataMapper.setup(:default, 'yaml:db')

class Picture
  include DataMapper::Resource

  property :id,       Serial
  property :title,    Text,       :required => true
  property :camera,   Text
  property :date,     Text
  property :author,   Text
  property :picture,  Text
  property :processed_picture, Text
  property :filename, Text,       :required => true

end

class Worker
  include Sidekiq::Worker
	def perform(id)
    Worker.convert id
	end
	def self.convert(id)
    image = Picture.first(id)
    img = Image.read_inline(image.picture)
    img.crop_resized!(100,100)
    img.qunatize(256,Magick::GRAYColorspace)
    img.update 'content', Base64.encode64(img.to_blob)
	end
end

DataMapper.finalize