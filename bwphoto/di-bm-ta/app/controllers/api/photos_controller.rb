class Api::PhotosController < ApplicationController

  def index
    render :nothing => true
  end
  
  def show
    render :nothing => true
  end
  
  def create
    data = JSON.parse(params[:data])
  
    @photo = Photo.new
    @photo.title            = data["title"]
    @photo.url              = data["url"]
    @photo.base64           = data["base64"]
    @photo.photo_file_name  = data["filename"]
    @photo.author           = data["author"]
    @photo.taken_at         = data["taken_at"]
    @photo.save!
    
    render :nothing => true
  end

end
