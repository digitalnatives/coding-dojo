require 'spec_helper'

describe FileLottery do
  let(:test_dir) {"test_data/folder"}
  let(:stream) { mock(IO) }

  subject { FileLottery.new(stream) }

  context "with existing directory" do
    before( :each ) do
      File.should_receive( :directory? ).and_return( true )
    end

    it "should randomize read files" do
      Dir.should_receive( :entries ).with( test_dir ).and_return([])      
      subject.should_receive( :random ).and_return([])
      stream.should_receive( :puts )
      subject.execute( test_dir )
    end
    
    it "should give back the result" do
      Dir.should_receive( :entries ).with( test_dir ).and_return([])      
      subject.should_receive( :random ).and_return( %w( 1 2 3 4 5 ) )
      stream.should_receive( :puts ).with( '1 2 3 4 5' )
      subject.execute( test_dir )
    end


    it "should read up the dir content without the dots" do
      Dir.should_receive( :entries ).with( test_dir ).and_return([".", "..", "1", "2", "3", "5", "4"])
      stream.should_receive( :puts )
      subject.execute( test_dir )
    end

    it "should get the dir path as an argument" do
      test_dir = "test_data/dojo"
      Dir.should_receive( :entries ).with( test_dir ).and_return([])
      stream.should_receive( :puts )
      subject.execute( test_dir )
    end
  end

  context "without existing directory" do
    it "should return empty string running on nonexisting dir" do
      test_dir = "test_data/nonexisting"
      File.should_receive( :directory? ).with( test_dir ).and_return( false )
      Dir.should_not_receive( :entries )
      stream.should_receive( :puts ).with( '' )
      subject.execute( test_dir )
    end
  end

  context "no idea yet" do
    it "should shuffle the content of an array" do
      array =  mock(Array)
      array.should_receive(:shuffle)
      subject.random(array)
    end

    it "should return empty string running on empty dir" do
      test_dir = "test_data/empty"
      File.should_receive( :directory? ).and_return( true )
      Dir.should_receive( :entries ).with( test_dir ).and_return([".", ".."])
      stream.should_receive( :puts ).with( '' )
      subject.execute( test_dir )
    end

  end


end

