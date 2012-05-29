# encoding: UTF-8

Given /^I have a user$/ do
  @user = double("object")
  @user.stub( :id ).and_return( 1 )
  @user.stub( :name ).and_return( "Lucas" )
end

When /^I request it's details$/ do
  @response = visit( "/users/#{@user.id}" )
end

Then /^I get back a user's details$/ do
  @response.should eql( { :id => @user.id, :name => @user.name } )
end

When /^I update it's details without errors$/ do
  page.driver.put( "/users/#{@user.id}", { :params => { :name => "Miki is the king" } } )
  @response = page.source
end

Then /^I get back a success message$/ do
  @response.should eql( { :error => 0 } )
end

When /^I update it's details with errors$/ do
  page.driver.post( "/users/#{@user.id}", { :params => { :name => "Lucas" } } )
  @response = page.source
end

Then /^I get back an error message$/ do
  @response.should eql( { :error => { :name => "Name can't be Lucas" } } )
end

When /^I request it's comments$/ do
  @response = visit( "/users/#{@user.id}/comments" )
end

Then /^I get back a user's comments$/ do
  @response.should eql( [{
    :id => 1,
    :message => "Lucas is silly! :)",
    :timestamp => 1
  }] )
end

When /^I add a new comment to him without error$/ do
  page.driver.post( "/users/#{@user.id}/comments", { :params => { :message => "Lucas is silly! :)" } } )
  @response = page.source
end

When /^I add a new comment to him with error$/ do
  page.driver.post( "/users/#{@user.id}/comments", { :params => { :message => "" } } )
  @response = page.source
end
