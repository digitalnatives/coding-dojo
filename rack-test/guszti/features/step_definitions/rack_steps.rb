Given /^I have a user with id (\d+) and name (.*)$/ do |id,name|
  @user = User.first_or_create :id => id.to_i, :name => name
end

When /^I get the user$/ do
  visit('/users/'+@user[:id].to_s)
end

Then /^I the username should be (.*)$/ do |name|
	user = JSON.parse page.source
  user['name'].should == name
end

Then /^I the id should be (\d+)$/ do |id|
	user = JSON.parse page.source
  user['id'].should == id.to_i
end

When /^I set the username to (.*)$/ do |name|
  name = '' if name == "''"
  name = CGI.escape name
	page.driver.post('/users/'+@user[:id].to_s+"?name=#{name}&_method=PUT")
end

Then /^I shouldnt get an error$/ do
	data = JSON.parse page.source
	data.error.should == 0
end

Then /^I should get an error$/ do
	data = JSON.parse page.source
	data.error.should == 1
end

Given /^I have a comment for the user with id (\d+) and message (.*)$/ do |id,message|
	@comment = {
  	id: id.to_i,
  	message: message
  }
end

When /^I get the comment$/ do
	visit('/users/'+@user[:id].to_s+'/comments')
end

Then /^The comment id should be (\d+)$/ do |id|
	comment = JSON.parse page.source
  comment['id'].should == id.to_i
end

Then /^The comment message should be (.*)$/ do |message|
	comment = JSON.parse page.source
  comment['message'].should == message
end

Then /^There should be a timestamp$/ do
	comment = JSON.parse page.source
  comment['timestamp'].should != nil
end

When /^I add a new comment with message (.*)$/ do |message|
	message = '' if message == "" 
	page.driver.post('/users/'+@user[:id].to_s+"comments?name=#{name}")
end
