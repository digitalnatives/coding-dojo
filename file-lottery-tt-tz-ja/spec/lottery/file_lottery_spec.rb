require 'spec_helper'

describe "FileLottery" do
  before(:all) do
    @arr = ["tmp/test/4", "tmp/test/1", "tmp/test/2", "tmp/test/3", "tmp/test/5"]
  end
  it "reads" do
    Dir.should_receive(:glob).and_return( @arr )
    FileLottery.reads("tmp/test").should eql @arr
  end
  it "randomizes" do
    @arr.should_receive(:shuffle).and_return( @arr.reverse )
    FileLottery.randomize(@arr).should eql(@arr.reverse)
  end
  it "prints" do
    FileLottery.print(@arr).should eql(@arr.join(","))
  end
end
