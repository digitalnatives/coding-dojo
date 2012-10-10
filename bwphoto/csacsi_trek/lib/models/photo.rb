class Photo
  include DataMapper::Resource

  property :id,         Serial
  property :title,       String
  property :camera, String
  property :author, String
  property :photo, String
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

  def tmp_path
    "/tmp/#{id}.tmp.jpg"
  end

  def photo_path
    "/public/photos/#{id}.tmp.jpg"
  end

  def photo_url
    "/photos/#{id}.tmp.jpg"
  end

  private
  def set_identificator
    self.identificator = SecureRandom.hex( 8 )
  end
end
