class MainController < ApplicationController

  def index
    @result = params[:number]
  end

end
