module Paperclip
  class Crop < Thumbnail
    def transformation_command
      ( crop_command || [] ) + super
    end

    def crop_command
      target = @attachment.instance
      [ " -crop #{target.crop_w}x#{target.crop_h}+#{target.crop_x}+#{target.crop_y}" ]
    end
  end
end