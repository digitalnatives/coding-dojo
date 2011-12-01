Given /^I have a converter$/ do
  @converter = NumeralConverter.new
end

When /^I convert (\d+) with my converter$/ do |number|
  @word = @converter.convert(number.to_i)
end

Then /^I should get "([^\"]*)"$/ do |expectation|
  @word.should eql(expectation)
end