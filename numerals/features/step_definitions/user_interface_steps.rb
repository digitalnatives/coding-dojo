Given /^I am on the main page$/ do
  visit "/"
end

When /^I enter (\d+) into my field$/ do |number|
  fill_in("number", :with => number)
end

When /^I enter something else than a number into my field$/ do
  fill_in("number", :with => "number")
end

When /^I press submit$/ do
  click_button("Submit")
end

Then /^I see "([^\"]*)" as a result$/ do |word|
  find(".result").should have_content(word)
end

Then /^I do not see any error just the content of the main page$/ do
  find(".result").should have_content("")
end

Then /^I see it as a word in the result$/ do
  find(".result").text =~ /\w+/
end