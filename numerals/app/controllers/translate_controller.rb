class TranslateController < ApplicationController
  def index
    
  end

  def do_translate
    @result = EnglishNumerals.new.translate(params[:number].to_i)
    respond_to do |format|
      format.json do
        render :json => {:result => @result}
      end
      format.js
    end
  end
end
