class BwimagesController < ApplicationController
  # GET /bwimages
  # GET /bwimages.json
  def index
    @bwimages = Bwimage.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bwimages }
    end
  end

  # GET /bwimages/1
  # GET /bwimages/1.json
  def show
    @bwimage = Bwimage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bwimage }
    end
  end

  # GET /bwimages/new
  # GET /bwimages/new.json
  def new
    @bwimage = Bwimage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bwimage }
    end
  end

  # GET /bwimages/1/edit
  def edit
    @bwimage = Bwimage.find(params[:id])
  end

  # POST /bwimages
  # POST /bwimages.json
  def create
    @bwimage = Bwimage.new(params[:bwimage])

    respond_to do |format|
      if @bwimage.save
        format.html { redirect_to @bwimage, notice: 'Bwimage was successfully created.' }
        format.json { render json: @bwimage, status: :created, location: @bwimage }
      else
        format.html { render action: "new" }
        format.json { render json: @bwimage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bwimages/1
  # PUT /bwimages/1.json
  def update
    @bwimage = Bwimage.find(params[:id])

    respond_to do |format|
      if @bwimage.update_attributes(params[:bwimage])
        format.html { redirect_to @bwimage, notice: 'Bwimage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bwimage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bwimages/1
  # DELETE /bwimages/1.json
  def destroy
    @bwimage = Bwimage.find(params[:id])
    @bwimage.destroy

    respond_to do |format|
      format.html { redirect_to bwimages_url }
      format.json { head :no_content }
    end
  end
end
