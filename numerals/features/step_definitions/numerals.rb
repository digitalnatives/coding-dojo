
Then /^I should see the number field$/ do
  page.find("input.number")
end

Then /^I should see the submit button$/ do
  page.find_button("commit")
end

Then /^I should see a number in human readable way$/ do
  page.find(".output").text =~ /\w+/
end

