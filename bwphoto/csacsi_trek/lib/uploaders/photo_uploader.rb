class ImageUploader < CarrierWave::Uploader::Base

  class FilelessIO < StringIO
    attr_accessor :original_filename
    attr_accessor :content_type
  end

  before :cache, :convert_base64

  def convert_base64(file)
    if file.respond_to?(:original_filename) &&
       file.original_filename.match(/^base64:/)
      fname = file.original_filename.gsub(/^base64:/, '')
      ctype = file.content_type
      decoded = Base64.decode64(file.read)
      file.file.tempfile.close!
      decoded = FilelessIO.new(decoded)
      decoded.original_filename = fname
      decoded.content_type = ctype
      file.__send__ :file=, decoded
    end
    file
  end
end
