class Photo < ActiveRecord::Base
  
  # validations
  validates :title, :presence => true
  validates :url, :presence => true, :unless => :photo_file_name_exists?
  validates :photo_file_name, :presence => true, :unless => :url_exists?
  
  # attributes
  attr_accessor :base64
  
  private
  
  def photo_file_name_exists?
    self.photo_file_name.present?
  end
  
  def url_exists?
    self.url.present?
  end
end
