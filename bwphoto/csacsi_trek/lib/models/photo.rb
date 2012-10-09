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

  validates_presence_of :title, :author, :camera, :authored_at, :photo
end
