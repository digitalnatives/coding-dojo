class Bwimage < ActiveRecord::Base
  attr_accessible :photo, :photo_cache, :url, :filename, :original_filename,
                  :title, :author, :taken_at, :camera

  attr_accessor :original_filename

  mount_uploader :photo, PhotoUploader

  #STATUSES = [ 'draft', 'downloading', 'processing', 'finished', 'download failed', 'processing failed' ]

  #after_save :process_photo

  validates :title, presence: true
  validates :author, presence: true
  validates :camera, presence: true
  validates :taken_at, presence: true
  validates :status, inclusion: { :in => STATUSES }

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
