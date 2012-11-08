module Paperclip
  class Grayscale < Thumbnail
    def transformation_command
      ( grayscale_command || [] ) + super
    end

    def grayscale_command
      target = @attachment.instance
      [ " -colorspace Gray" ]
    end
  end
end