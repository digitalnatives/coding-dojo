class Api::BwimageController < ApplicationController
  def upload

  end

  def index
  	Bwimage.all.to_json
  end

  def create
  end

  def delete
  end
end
