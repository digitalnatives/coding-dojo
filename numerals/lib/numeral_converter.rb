class NumeralConverter
    @@cardinal_numbers = {
     1 => "one",
     2 => "two",
     3 => "three",
     4 => "four",
     5 => "five",
     6 => "six",
     7 => "seven",
     8 => "eight",
     9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty"
  }
  
  def convert(number)
    if cardinal_number?(number)
      @@cardinal_numbers[number]
    else
      last_number = number % 10
      "#{@@cardinal_numbers[number - last_number]}-#{@@cardinal_numbers[last_number]}"
   end
  end

  private
  def cardinal_number?(number)
    @@cardinal_numbers.keys.include?(number)
  end
end