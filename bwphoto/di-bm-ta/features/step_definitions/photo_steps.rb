Given /^I post JSON to "(.*?)" with:$/ do |to, json|
  post(to, { :photo => json }, {"Content-type" => "application/json"})
end

Then /^I should get a response with status (\d+)$/ do |status|
  last_response.status.should == status.to_i
end

Then /^I should have (\d+) photo\(s\) in the database$/ do |count|
  Photo.count.should == count.to_i
end

Then /^I should have no photo in the database$/ do
  Photo.count.should == 0
end

Given /^the following photos exist:$/ do |table|
  table.hashes.map { |hash| FactoryGirl.create(:photo, :photo, hash) }
end

When /^I visit "(.*?)"$/ do |path|
  get path
  p last_json
end
