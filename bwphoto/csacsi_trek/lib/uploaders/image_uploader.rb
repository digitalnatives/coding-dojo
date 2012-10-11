class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

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

  def is_processing_delayed?(img = nil)
    !! @is_processing_delayed
  end

  def is_processing_immediate?(img = nil)
    ! is_processing_delayed?
  end

  def is_processing_delayed=(value)
    @is_processing_delayed = value
  end

  # Create different versions of your uploaded files:
  version :small, :if => :is_processing_delayed? do
    process :resize_to_limit => [100, 100]
  end

  version :gray, :from_version => :small, :if => :is_processing_delayed? do
    process :convert_to_grayscale
  end

  def convert_to_grayscale
    manipulate! do |img|
      img.colorspace("Gray")
      img.brightness_contrast("-30x0")
      img = yield(img) if block_given?
      img
    end
  end
end
