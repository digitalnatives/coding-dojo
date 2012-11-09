require "base64"

DataMapper.setup(:default, 'yaml:db')

class Picture
  include DataMapper::Resource

  property :id,                 Serial
  property :title,              Text,       :required => true
  property :camera,             Text
  property :date,               Text
  property :author,             Text
  property :picture,            Binary,       :lazy => false
  property :processed_picture,  Text,       :lazy => false
  property :filename,           Text,       :required => true, :lazy => false
  property :status,             Text,       :default => 'queued'

  validates_with_method :validate_params

  def validate_params
    errors = []
    unless self.picture.nil?
      errors << "Wrong base64!" if Base64.decode64(self.picture) == ""
    end
    errors << "Only images can be uploaded!" unless self.filename =~ (/\.(png|jpg|gif)$/i)
    if errors.length > 0
      errors.unshift false
      errors
    else
      true
    end
  end

end

class Worker
  include Sidekiq::Worker

  def perform(id)
    self.convert id
  end

	def convert(id)
    puts 'Converting picture --------> '+id.to_s
    img = Picture.get(id)
    if img
      content = img.picture
      begin
        unless content
          content = Base64.encode64(Curl::Easy.perform(img.filename).body_str)
        end
        if content
          image = Magick::Image.read_inline(content).first
          image.crop_resized!(100,100)
          image = image.quantize(256,Magick::GRAYColorspace)
          img.update({
            processed_picture: Base64.encode64(image.to_blob),
            status: 'processed'
          })
        end
      rescue
        img.update({status: 'failed'})
      end
      img.save
    end
	end
end

DataMapper.finalize