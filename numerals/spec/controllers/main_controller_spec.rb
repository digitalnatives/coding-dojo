require 'spec_helper'

describe MainController do
  render_views

  it "should respond to index" do
    subject.respond_to?(:index).should be_true
  end

  it "should set result inst variable from params" do
    post(:index, { :number => 42 } )
    assigns(:result).should eql("42")
  end

  context "converter" do
    it "should convert 1 to one" do
        post(:index, { :number => 1 } )
        response.body.should =~ /one/m
    end

    it "should convert the incoming 41 to fourty-one" do
      post(:index, { :number => 41 } )
      response.body.should =~ /fourty-one/m
    end
  end

end
