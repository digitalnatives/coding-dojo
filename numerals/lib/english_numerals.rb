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

  def translate_under_thousand(number)
    return NUMBER_TABLE[number] if number <= 20

    three_digits = number / 100
    rest_three_digits = number % 100

    two_digits = rest_three_digits / 10
    rest_two_digits = rest_three_digits % 10

    to_return = []
    to_return_hyphen = []
    to_return << "#{NUMBER_TABLE[three_digits]} hundred" unless three_digits == 0
    to_return_hyphen << TWO_DIGITS[two_digits] unless two_digits == 0
    to_return_hyphen << NUMBER_TABLE[rest_two_digits] unless rest_two_digits == 0

    to_return << to_return_hyphen.join("-") unless to_return_hyphen.empty?

    return to_return.join(" ")
  end

  def translate(number)
    raise ArgumentError if number > 999_999_999

    to_return = []

    million_digits = number / 1_000_000
    rest_million_digits = number % 1_000_000

    thousand_digits = rest_million_digits / 1_000
    rest_thousand_digits = rest_million_digits % 1_000

    to_return << "#{translate_under_thousand(million_digits)} million" unless million_digits == 0
    to_return << "#{translate_under_thousand(thousand_digits)} thousand" unless thousand_digits == 0
    to_return << "#{translate_under_thousand(rest_thousand_digits)}" unless rest_thousand_digits == 0

    return to_return.join(" and ")
  end

end