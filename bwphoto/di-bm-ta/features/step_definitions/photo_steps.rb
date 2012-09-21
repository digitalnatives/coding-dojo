Given /^I post JSON to "(.*?)" with:$/ do |to, json|
  post(to, JSON.parse(json), {"Content-type" => "application/json"})
end

Then /^I should get a response with status (\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should have (\d+) photo\(s\) in the database$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should have no photo in the database$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^the following photos exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

When /^I visit "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
