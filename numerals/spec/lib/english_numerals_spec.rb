require "spec_helper.rb"

describe EnglishNumerals do
  it "should translate number between 1 and 12" do
    {
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
      12 => "twelve"
    }.each do |number, translation|
      EnglishNumerals.translate(number).should eql(translation)
    end

  end

  it "should translate a number under 100" do
    {
        44 => "forty-four",
        50 => "fifty",
        66 => "sixty-six",
        77 => "seventy-seven"
      }.each do |number, translation|
     EnglishNumerals.translate(number).should eql(translation)
    end
  end

  it "should translate a number under 1000" do
    {
        945 => "nine hundred forty-five",
        300 => "three hundred",
        450 => "four hundred fifty",
        100 => "one hundred"
      }.each do |number, translation|
     EnglishNumerals.translate(number).should eql(translation)
    end
  end

  it "should translate a number under 1_000_000" do
    {
        945_654 => "nine hundred forty-five thousand and six hundred fifty-four",
        600_000 => "six hundred thousand",
        450_001 => "four hundred fifty thousand and one"
      }.each do |number, translation|
     EnglishNumerals.translate(number).should eql(translation)
    end
  end

end