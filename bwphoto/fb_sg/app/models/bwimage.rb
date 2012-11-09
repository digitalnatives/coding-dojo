class Bwimage < ActiveRecord::Base
  attr_accessible :photo, :photo_cache, :url, :filename, :original_filename,
                  :title, :author, :taken_at, :camera, :file

  attr_accessor :original_filename, :file

  mount_uploader :photo, PhotoUploader

  #after_save :process_photo
  before_validation :convert_base64

  validates :title, presence: true
  validates :author, presence: true
  validates :camera, presence: true
  validates :taken_at, presence: true

  include AASM
  aasm :column => 'status' do
    state :draft, :initial => true
    state :downloading
    state :processing, :enter => :recreate_delayed_versions!
    state :finished
    state :download_failed
    state :processing_failed

    event :download do
      transitions :from => :draft, :to => :downloading
    end

    event :process, :after => :finish! do
      transitions :from => [:draft, :downloading], :to => :processing
    end

    event :finish do
      transitions :from => :processing, :to => :finished
    end

    event :fail do
      transitions :from => :draft, :to => :download_failed
      transitions :from => :downloading, :to => :processing_failed
    end
  end

  # http://code.dblock.org/carrierwave-delayjob-processing-of-selected-versions
  def recreate_delayed_versions!
    photo.is_processing_delayed = true
    photo.recreate_versions!
  rescue
    fail!
  end

  def process_photo
    if url.present?
      Resque.enqueue(BwimageTask::Remote, id, url)
    else
      Resque.enqueue(BwimageTask::Local, id)
    end
  end

  private

  def convert_base64
    # http://stackoverflow.com/questions/9854916/base64-upload-from-android-java-to-ror-carrierwave
    if file.present?
      tempfile = Tempfile.new("fileupload")
      tempfile.binmode
      #get the file and decode it with base64 then write it to the tempfile
      tempfile.write(Base64.decode64(file))

      #create a new uploaded file
      uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, 
                                                             :filename => filename || SecureRandom.hex(4), 
                                                             :original_filename => filename || SecureRandom.hex(4))
      self.photo = uploaded_file
    end
  end

end
