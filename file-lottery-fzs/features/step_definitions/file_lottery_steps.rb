Given /^I have a folder with five different files no directories$/ do
  dir = File.expand_path("../../../", __FILE__)
  test_data_folder = File.join(dir, "test_data","folder")
  FileUtils.rm_rf(test_data_folder)
  FileUtils.mkdir_p(test_data_folder)

  1.upto(5) do |filename|
    File.new(File.join(test_data_folder, filename.to_s), "w")
  end
end

When /^I execute my application$/ do
  @stream = OutputDouble.new
  file_lottery = FileLottery.new(@stream)
  file_lottery.execute
end

Then /^I see the content of the folder in random order$/ do
  output = @stream.message.split(" ").sort.join(" ")
  output.should eql('1 2 3 4 5')
end

When /^I execute my application twice$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I see that the order of the result of the executions are different$/ do
  pending # express the regexp above with the code you wish you had
end

class OutputDouble
  attr_reader :message
  def puts(s)
    @message = s
  end
end
