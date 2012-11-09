class Photo < ActiveRecord::Base
  # status handling
  STATUSES = %w(queued processing failed_to_download failed_to_decode failed processed).freeze

  STATUSES.each do |st|
    scope st, where(status: st)

    define_method "#{st}?" do
      status == st
    end

    define_method "#{st}!" do
      update_attribute :status, st
    end
  end

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
  has_attached_file :photo,
                    styles: {converted: '100x100#'},
                    processors: [:grayscale, :thumbnail]

  before_photo_post_process { |photo| false if photo.queued? }

  private

  def start_worker
    PhotoConverterWorker.perform_async(self.id)
  end

  def process_base64
    return unless self.base64.present?

    logger.debug "processing base64"
    dst = Tempfile.new([File.basename(self.original_file_name), File.extname(self.original_file_name)])
    dst.binmode
    dst.write Base64.decode64(base64)
    dst.close
    self.photo = File.new(dst,'r')
  end

  def photo_file_name_exists?
    self.photo_file_name.present?
  end

  def url_exists?
    self.url.present?
  end
end
