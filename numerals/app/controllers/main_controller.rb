class MainController < ApplicationController

  def index
    @result = convert( params[:number].to_i )
  end

  private

  def convert( number )

    unit = %w[zero one two three four five six seven eight nine]
    teen = %w[ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen]
    tens = %w[zero ten twenty thirty fourty fifty sixty seventy eighty ninety]
    qtys = %w[hundred thousand million billion trillion quadrillion quintillion]
    hundred = "hundred"
    sepr = "and"    

    result = ""
    begin
      if number < 10
        result += unit[number]
        number = 0
      elsif number < 20
        result += teen[number - 10]
        number = 0
      elsif number < 100
        result += tens[number / 10].to_s + unit[ number % 10 ].to_s 
        number = 0
      elsif number < 1000
        result += unit[number / 100].to_s + hundred + " "
        number -= (number / 100) * 100
      else
        result += "N/A"
        number = 0
      end
    end while number > 0

    result
  end

end
