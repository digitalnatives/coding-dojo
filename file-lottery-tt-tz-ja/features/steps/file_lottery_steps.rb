# TODO
Given /^I have a folder with five different files no directories$/ do
  FileUtils.rm_rf("tmp/test")
  FileUtils.mkdir_p("tmp/test")
  1.upto(5) do |i|
    File.new "tmp/test/#{i}", "w"
  end
end

When /^I execute my application$/ do
  @out = `bin/lottery tmp/test`
end

Then /^I see the content of the folder in random order$/ do
  Dir.glob("tmp/test/*").each do |f|
    @out.include?(f).should be_true
  end
  @out.should_not eql(Dir.glob("tmp/test/*"))
end

When /^I execute my application twice$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I see that the order of the result of the executions are different$/ do
  pending # express the regexp above with the code you wish you had
end

