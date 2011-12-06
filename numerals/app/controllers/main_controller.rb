require 'numeral_converter'

class MainController < ApplicationController
  def index
    unless params[:number].blank? || params[:number].is_a?(Numeric)
      @result = NumeralConverter.new.convert(params[:number].to_i)
    else
      @result = ""
    end
  end
end
