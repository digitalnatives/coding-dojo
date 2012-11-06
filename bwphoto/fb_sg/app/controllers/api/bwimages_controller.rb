class Api::BwimagesController < ApplicationController

  # POST /bwimages
  # POST /bwimages.json
  def create

    begin
      data = JSON.parse(params[:bwimage])
      # http://stackoverflow.com/questions/9854916/base64-upload-from-android-java-to-ror-carrierwave
      if data["file"].present?
        tempfile = Tempfile.new("fileupload")
        tempfile.binmode
        #get the file and decode it with base64 then write it to the tempfile
        tempfile.write(Base64.decode64(data["file"]))

        #create a new uploaded file
        uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, 
                                                               :filename => data["filename"] || SecureRandom.hex(4), 
                                                               :original_filename => data["filename"] || SecureRandom.hex(4))
        data.delete("file")
        data["photo"] = uploaded_file
      end
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
