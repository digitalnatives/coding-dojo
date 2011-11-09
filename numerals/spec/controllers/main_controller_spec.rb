require 'spec_helper'

describe MainController do
  it "should respond to index" do
    subject.respond_to?(:index).should be_true
  end

  it "should set result inst variable from params" do
    post(:index, { :number => 42 } )
    assigns(:result).should eql("42")
  end

end
