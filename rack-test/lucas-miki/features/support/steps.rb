# encoding: UTF-8

Given /^I have a user$/ do
  @user = mock( Object )
  @user.stub( :id ).and_return( 1 )
end

When /^I request it's details$/ do
  @response = visit( "/users/#{@user.id}" )
end

Then /^I get back a user's details$/ do
  @response == { :id => @user.id, :name => @user.name }
end

When /^I update it's details without errors$/ do
  page.driver.put( "/users/#{@user.id}", { :params => { :name => "Miki is the king" } } )
end

Then /^I get back a success message$/ do
  @response == { :error => 0 }
end

When /^I update it's details with errors$/ do
  page.driver.post( "/users/#{@user.id}", { :params => { :name => "Lucas" } } )
end

Then /^I get back an error message$/ do
  @response == { :error => { :name => "Name can't be Lucas" } }
end

When /^I request it's comments$/ do
  @response = visit( "/users/#{@user.id}/comments" )
end

Then /^I get back a user's comments$/ do
  @response == [{
    :id => 1,
    :message => "Lucas is silly! :)",
    :timestamp => 1
  }]
end

When /^I add a new comment to him without error$/ do
  
end

When /^I add a new comment to him with error$/ do
  
end
