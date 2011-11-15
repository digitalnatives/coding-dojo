class MainController < ApplicationController

  def index
    if params[:number].to_i == 1
      @result = "one"
    elsif params[:number].to_i == 41
      @result = "fourty-one"  
    else
      @result = params[:number]
    end
  end

end
