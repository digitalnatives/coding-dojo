require 'spec_helper'

describe Photo do
  it "should be valid" do
    FactoryGirl.build(:photo).should be_valid
  end
  
  
end
