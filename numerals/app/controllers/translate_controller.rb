class TranslateController < ApplicationController
  def index
    
  end

  def do_translate
    @result = EnglishNumerals.new.translate(params[:number].to_i)
  end
end
