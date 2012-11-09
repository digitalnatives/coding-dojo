class Api::PhotosController < ApplicationController

  respond_to :json

  def index
    respond_with Photo.processed
  end

  def show
    @photo = Photo.find(params[:id])
    @photo.processed? ? respond_with(@photo) : render(json: {error: "photo isn't available yet"}, status: 450)
  rescue ActiveRecord::RecordNotFound
    render(json: {error: "photo isn't found"}, status: 404)
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
    respond_with @photo
  rescue => e
    render json: {error: e.message}, status: 500
  end

end
