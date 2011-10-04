require 'spec_helper'

describe "FileLottery" do
  before( :each ) do
    @stream = mock(IO)

    @test_dir = "test_data/folder"

    @file_lottery = FileLottery.new(@stream)
  end

  it "should read up the dir content without the dots" do
    Dir.should_receive( :entries ).with( @test_dir ).and_return([".", "..", "1", "2", "3", "5", "4"])
    @stream.should_receive( :puts )
    @file_lottery.execute( @test_dir )
  end

  it "should randomize read files" do
    @file_lottery.should_receive( :random ).and_return([])
    @stream.should_receive( :puts )
    @file_lottery.execute( @test_dir )
  end
  
  it "should give back the result" do
    @file_lottery.should_receive( :random ).and_return( %w( 1 2 3 4 5 ) )
    @stream.should_receive( :puts ).with( '1 2 3 4 5' )
    @file_lottery.execute( @test_dir )
  end

  it "should shuffle the content of an array" do
    array =  mock(Array)
    array.should_receive(:shuffle)
    @file_lottery.random(array)
  end

  it "should get the dir path as an argument" do
    test_dir = "test_data/dojo"
    File.should_receive( :directory? ).and_return( true )
    Dir.should_receive( :entries ).with( test_dir ).and_return([])
    @stream.should_receive( :puts )
    @file_lottery.execute( test_dir )
  end

  it "should return empty string running on empty dir" do
    test_dir = "test_data/empty"
    File.should_receive( :directory? ).and_return( true )
    Dir.should_receive( :entries ).with( test_dir ).and_return([".", ".."])
    @stream.should_receive( :puts ).with( '' )
    @file_lottery.execute( test_dir )
  end

  it "should return empty string running on nonexisting dir" do
    test_dir = "test_data/nonexisting"
    File.should_receive( :directory? ).with( test_dir ).and_return( false )
    Dir.should_not_receive( :entries )
    @stream.should_receive( :puts ).with( '' )
    @file_lottery.execute( test_dir )
  end

end
