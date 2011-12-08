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

Given /^The api receives a translation request with number "([^"]*)"$/ do |number|
  visit do_translate_path(:format => :json, :number => number)
end

Then /^The response should contain "([^"]*)" as result$/ do |result|
  JSON.parse(page.source)['result'].should eql(result)
end

