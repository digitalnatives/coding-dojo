class Bwimage < ActiveRecord::Base
  require "open-uri"
  
  attr_accessible :author, :camera, :date, :url, :title, :image, :file, :filename, :content_type
	attr_accessor :file

  validate :filename, :presence => true, :if => lambda{|bwimage| bwimage.url.nil? }
  validate :content_type, :presence => true

	has_attached_file :image, :styles => { :thumbnail => "x100" }

	after_initialize :decode_base64_image, :if => lambda{|bwimage| bwimage.file.present?}
  after_commit :start_worker, :on => :create

  def crop_and_grayscale
  	thumb_path = self.image.path(:thumbnail)
  	status = system("convert #{thumb_path} -gravity Center -crop 100x100+0+0 -type GrayScale #{thumb_path}") ? "processed" : "processing_failed"
  	self.update_attribute(:status, status)
  end

  def download_image_from_url
    begin
      if url
        original_filename = File.basename(url)
        temp_dir_path = File.join(Rails.root, "tmp", Time.now.to_i.to_s)
        FileUtils.mkdir_p(temp_dir_path)
        
        tf = File.open(File.join(temp_dir_path, filename), 'w')
        tf.write open(url).read.force_encoding("UTF-8")
        tf.class_eval do
          attr_accessor :content_type, :filename
        end
        tf.filename = original_filename
        tf.content_type = self.content_type

        update_attribute(:filename, original_filename)
        self.image = tf
        self.status = "file_downloaded"
        self.save
        tf.close
      end
    rescue => e
      logger.error e.message
      logger.error e.inspect + e.backtrace.join("\n")
      update_attribute(:status, "download_failed")
    end
  end

  private

  # based on https://gist.github.com/1012107
  def decode_base64_image
    if file && filename
      decoded_data = Base64.decode64(file)

      data = StringIO.new(decoded_data)
      data.class_eval do
        attr_accessor :file_name, :content_type
      end

      data.content_type = "image/jpg"

      self.image = data
      self.image.instance_write(:file_name, filename)

      self.status = "file_downloaded"
    end
  end

  def start_worker
    puts self.inspect
    BwimageWorker.perform_async( self.id )
  end

end
