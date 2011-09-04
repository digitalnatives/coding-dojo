require 'spec_helper'

describe "FileLottery" do
  before( :each ) do
    @stream = mock(IO)

    @file_lottery = FileLottery.new(@stream)
  end

  it "should print out the result" do
    @stream.should_receive( :puts ).with('1 2 3 5 4')
    @file_lottery.execute
  end

  it "should read up the dir content" do
    Dir.should_receive( :entries ).with( "test_data/folder" )
    @stream.should_receive( :puts )
    @file_lottery.execute

  end

end
