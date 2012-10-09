class Photo < ActiveRecord::Base
  
  # validations
  validates :title, :presence => true
  validates :url, :presence => true, :unless => :photo_file_name_exists?
  validates :photo_file_name, :presence => true, :unless => :url_exists?
  
  # attributes
  attr_accessor :base64
  
  # callback methods
  before_validation :process_base64, :on => :create
  
  # extensions
  has_attached_file :photo,
    styles: {large: '530x290>', small: '160x160#', medium: '100x100#' },
    default_style: :small
  
  private
  
  def process_base64
    return unless self.base64.present?
    
    self.photo_file_name = "hello"
  end
  
  def photo_file_name_exists?
    self.photo_file_name.present?
  end
  
  def url_exists?
    self.url.present?
  end
end
