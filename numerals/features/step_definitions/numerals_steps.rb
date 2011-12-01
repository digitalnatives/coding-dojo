Given /^I am on the main page$/ do
  visit "/"
end

When /^I enter (\d+) into my field$/ do |number|
  fill_in("number", :with => number)
end

When /^I press submit$/ do
  click_button("Submit")
end

Then /^I see "([^\"]*)" as a result$/ do |word|
  find(".result").should have_content(word)
end