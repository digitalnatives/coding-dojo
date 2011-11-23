Given /^I am on the translation page$/ do
  visit translate_path
end

When /^I translate "([^"]*)"$/ do |number|
  fill_in("number", :with => number)
  click_button("do the trick")
end

Then /^I should get "([^"]*)" as result$/ do |result|
  find("#result").should have_content(result)
end
