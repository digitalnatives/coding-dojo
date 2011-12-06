require 'spec_helper'

describe NumeralConverter do
 context "in case the number is between 21 and 99" do
   subject {NumeralConverter.new}
   it "should find the proper leading cardinal number" do
     subject.convert(21).should =~ /^twenty/
   end

   it "should add a hyphen after the leading cardinal number" do
     subject.convert(21).should =~ /^[a-z]+-/
   end

   it "should concatenates the closing cardinal number after the hyphen" do
     subject.convert(21).should =~ /^[a-z]+-one$/
   end
 end
end