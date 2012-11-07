class Bwimage < ActiveRecord::Base
  attr_accessible :photo, :photo_cache, :url, :filename, :original_filename,
                  :title, :author, :taken_at, :camera

  attr_accessor :original_filename

  mount_uploader :photo, PhotoUploader

  #after_save :process_photo

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

    event :process do
      transitions :from => [:draft, :downloading], :to => :processing
    end

    event :finish do
      transitions :from => :processing, :to => :finished
    end

    event :fail do
      transitions :from => :downloading, :to => :download_failed
      transitions :from => :processing, :to => :processing_failed
    end
  end

  # http://code.dblock.org/carrierwave-delayjob-processing-of-selected-versions
  def recreate_delayed_versions!
    photo.is_processing_delayed = true
    photo.recreate_versions!
  end

  def process_photo
    if url.present?
      Resque.enqueue(BwimageTask::Remote, id, url)
    else
      Resque.enqueue(BwimageTask::Local, id)
    end
  end

end
