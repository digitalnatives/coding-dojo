class Photo < ActiveRecord::Base

  # validations
  validates :title, :presence => true
  validates :url, :presence => true, :unless => :photo_file_name_exists?
  validates :photo_file_name, :presence => true, :unless => :url_exists?

  # attributes
  attr_accessor :base64
  attr_accessor :original_file_name, :original_content_type

  # callback methods
  before_validation :process_base64, :on => :create
  after_commit :start_worker, on: :create

  # extensions
  has_attached_file :photo

  private

  def start_worker
    PhotoConverterWorker.perform_async(self.id)
  end

  def process_base64
    return unless self.base64.present?
    
    logger.debug "processing base64"
    
    StringIO.open(Base64.decode64(base64)) do |data|
      data.original_file_name = self.original_file_name
      data.content_type = self.original_file_name
      self.photo = data
    end
  end

  def photo_file_name_exists?
    self.photo_file_name.present?
  end

  def url_exists?
    self.url.present?
  end
end
