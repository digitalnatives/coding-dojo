class NumeralConverter
    @@uncomplicated_numbers = {
     1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six",
     7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten", 11 => "eleven", 12 => "twelve",
     13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen",
     18 => "eighteen", 19 => "nineteen", 20 => "twenty", 30=> "thirty", 40=> "forty",
     50 => "fifty", 60 => "sixty", 70 => "seventy", 80 => "eigthy", 90 => "ninety",
     100 => "hundred", 1000 => "thousand", 1000000 => "million"
  }

  def convert(number)
    if uncomplicated_number?(number)
      @@uncomplicated_numbers[number]
    elsif number > 1000
      group_index = (Math.log10(number) / 3).to_i
      second_part_as_uncomplicated = (10 ** (group_index * 3))
      the_first_part_of_the_number = number / second_part_as_uncomplicated
      rest = number % second_part_as_uncomplicated

      result = "#{convert(the_first_part_of_the_number)} #{@@uncomplicated_numbers[second_part_as_uncomplicated]}"
      result += " #{convert(rest)}" if rest > 0
      result
    elsif number > 100
      rest = number % 100
      result = "#{@@uncomplicated_numbers[number / 100]} hundred"
      result += " and #{convert(rest)}" if rest > 0
      result
    else
      last_number = number % 10
      "#{@@uncomplicated_numbers[number - last_number]}-#{@@uncomplicated_numbers[last_number]}"
   end
  end

  private
  def uncomplicated_number?(number)
    @@uncomplicated_numbers.keys.include?(number)
  end
end