class Api::BwimagesController < ApplicationController

  # POST /bwimages
  # POST /bwimages.json
  def create

    begin
      data = JSON.parse(params[:bwimage])
    rescue TypeError => e
      logger.error "Cannot parse params as JSON #{params[:bwimage]}"
    end

    @bwimage = Bwimage.new(data)

    respond_to do |format|
      if @bwimage.save
        @bwimage.process_photo
        FayeClient::photo_added(@bwimage)
        format.html { head 200 }
        format.json { head 200 }
        # format.json { render json: @bwimage, status: :created, location: @bwimage }
      else
        format.html { render json: @bwimage.errors, status: :unprocessable_entity }
        format.json { render json: @bwimage.errors, status: :unprocessable_entity }
      end
    end
  end

end
