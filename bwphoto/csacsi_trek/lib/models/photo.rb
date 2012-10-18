require_relative '../uploaders/image_uploader'
class Photo
  include DataMapper::Resource

  property :id,         Serial
  property :title,       String
  property :camera, String
  property :author, String
  property :image, String
  property :photo_content_type, String
  property :authored_at, DateTime
  property :created_at, DateTime
  property :updated_at, DateTime
  property :identificator, String
  property :image_processing, Boolean
  property :image_tmp, String

  validates_presence_of :title, :author, :camera, :authored_at, :photo

  mount_uploader :image, ImageUploader
  process_in_background :image
  store_in_background :image

  class << self
    def create_from_params( params )
      if params[:url].present?
        create_from_url( params )
      else
        create_from_base64( params )
      end
    end

    def create_from_base64( params )
      base64 = params.slice( :photo )
      photo = new( params )

      File.open( photo.photo_tmp_file_name, 'wb') {|f|
        f.write( Base64.decode64( base64 ) ) }
    end

    def create_from_url( params )
      DownloadWorker.perform_async( remote_url, tmp_path, destination )
    end
  end

  # http://code.dblock.org/carrierwave-delayjob-processing-of-selected-versions
  def recreate_delayed_versions!
    image.is_processing_delayed = true
    image.recreate_versions!
  end

end
