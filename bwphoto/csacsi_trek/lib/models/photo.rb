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

  validates_presence_of :title, :author, :camera, :authored_at, :photo

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

      tmp_path = photo.tmp_path
      destination = photo.
      File.open( photo.photo_tmp_file_name, 'wb') {|f|
        f.write( Base64.decode64( base64 ) ) }
      ConvertWorker.perform_async( tmp_path, destination )
    end

    def create_from_url( params )

      DownloadWorker.perform_async( remote_url, tmp_path, destination )
    end
  end

  mount_uploader :image, ImageUploader

  # http://code.dblock.org/carrierwave-delayjob-processing-of-selected-versions
  def recreate_delayed_versions!
    image.is_processing_delayed = true
    image.recreate_versions!
  end

end
