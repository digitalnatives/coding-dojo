Given /^I have a folder with five different files no directories$/ do
  FileUtils.rm_rf(MyCucumber::TEST_DATA_FOLDER)
  FileUtils.mkdir_p(MyCucumber::TEST_DATA_FOLDER)

  1.upto(5) do |filename|
    File.new(File.join(MyCucumber::TEST_DATA_FOLDER, filename.to_s), "w")
  end
end

When /^I execute my application$/ do
  @stream = OutputDouble.new
  file_lottery = FileLottery.new(@stream)
  file_lottery.execute(MyCucumber::TEST_DATA_FOLDER)
end

Then /^I see the content of the folder in random order$/ do
  output = @stream.message.split(" ").sort.join(" ")
  output.should eql('1 2 3 4 5')
end

When /^I execute my application 1000 times$/ do
  @stream = OutputDouble.new
  file_lottery = FileLottery.new(@stream)
  @results = []
  1000.times do
    file_lottery.execute(MyCucumber::TEST_DATA_FOLDER)
    @results << @stream.message
  end
end

Then /^I see that the order of the result of the executions are different at least once$/ do
  @results.uniq.size.should > 1
end

When /^I add a file to the folder$/ do
  File.new(File.join(MyCucumber::TEST_DATA_FOLDER, "10"), "w")
end

Then /^It will appear in the result$/ do
  output = @stream.message.split(" ")
  output.should include("10")
end

When /^I execute my application bin$/ do
  @bin_output = `bin/lottery #{MyCucumber::TEST_DATA_FOLDER}`
end

Then /^It should return to shell with (\d+)$/ do |arg1|
  @bin_output.size.should > 0
end



class OutputDouble
  attr_reader :message
  def puts(s)
    @message = s
  end
end
