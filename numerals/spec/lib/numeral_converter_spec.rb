require 'spec_helper'

describe NumeralConverter do
 context "in case the number is between 21 and 99" do
   subject {NumeralConverter.new}
   it "should find the proper leading uncomplicated number" do
     subject.convert(21).should =~ /^twenty/
   end

   it "should add a hyphen after the leading uncomplicated number" do
     subject.convert(21).should =~ /^[a-z]+-/
   end

   it "should concatenates the closing uncomplicated number after the hyphen" do
     subject.convert(21).should =~ /^[a-z]+-one$/
   end
 end
 
 context "in case the number is between 101 and 999" do
   it "should start with the uncomplicated number of the hundreds" do
     subject.convert(719).should =~ /^seven hundred/
   end
   
   it "should add 'and' after the hundreds" do
     subject.convert(719).should =~ /^[a-z]+ hundred and/
   end
   
   it "should concatenates the rest as described before" do
     subject.convert(719).should =~ /^[a-z]+ hundred and nineteen$/
   end
   
   it "should not concatenate anything if there are no tens or ones" do
     subject.convert(200).should =~ /hundred$/
   end
 end
end