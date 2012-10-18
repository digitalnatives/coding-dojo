class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay

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
  version :small_gray, :if => :is_processing_delayed? do
    process :resize_to_fill => [100, 100]
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
