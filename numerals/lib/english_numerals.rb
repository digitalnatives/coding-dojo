class EnglishNumerals

  NUMBER_TABLE = {
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
    19 => "nineteen"
  }

  TWO_DIGITS = {
    2 => "twenty",
    3 => "thirty",
    4 => "forty",
    5 => "fifty",
    6 => "sixty",
    7 => "seventy",
    8 => "eighty",
    9 => "ninety"
  }

  def self.translate(number)
    self.new.translate(number)
  end

  def translate(number)
    return NUMBER_TABLE[number] if number <= 20

    two_digits = number / 10
    rest = number % 10

    to_return = []
    to_return << TWO_DIGITS[two_digits]
    to_return << NUMBER_TABLE[rest] unless rest == 0

    return to_return.join("-")

  end
end