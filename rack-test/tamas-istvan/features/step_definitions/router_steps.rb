World(Rack::Test::Methods)


Given /^I go to the "(.*?)" page$/ do |arg1|
  path = '/users'
  case arg1
  when /user #(\d+)/
    path << "/#{$1}"
  when /main/
    path = '/'
  end
  get path
end

Then /^I should be redirected to the "(.*?)" page$/ do |arg1|
  current_path.should == '/users'
end

Given /^the request type is "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the "(.*?)"'s JSON object$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^the POST data is '\{id: (\d+), name: "(.*?)"\}'$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "(.*?)" response status$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^I go to the "(.*?)" page of "(.*?)" page$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a JSON object of "(.*?)"'s "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Given /^the POST data is '\{message: "(.*?)"\}'$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should get "(.*?)" response$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
