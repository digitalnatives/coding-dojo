require 'spec_helper'

describe "FileLottery" do
  before( :each ) do
    @stream = mock(IO)

    @file_lottery = FileLottery.new(@stream)
  end

  it "should read up the dir content without the dots" do
    Dir.should_receive( :entries ).with( "test_data/folder" ).and_return([".", "..", "1", "2", "3", "5", "4"])
    @stream.should_receive( :puts )
    @file_lottery.execute
  end

  it "should randomize read files" do
    @file_lottery.should_receive( :random ).and_return([])
    @stream.should_receive( :puts )
    @file_lottery.execute
  end
  
  it "should give back the result" do
    @file_lottery.should_receive( :random ).and_return( %w( 1 2 3 4 5 ) )
    @stream.should_receive( :puts ).with( '1 2 3 4 5' )
    @file_lottery.execute
  end

  it "should shuffle the content of an array" do
    array =  mock(Array)
    array.should_receive(:shuffle)
    @file_lottery.random(array)
  end

end
