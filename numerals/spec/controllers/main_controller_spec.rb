require 'spec_helper'

describe MainController do
  render_views

  it "should respond to index" do
    subject.respond_to?(:index).should be_true
  end

  it "should set result inst variable from params" do
    post(:index, { :number => 42 } )
    assigns(:result).should eql("fourtytwo")
  end

  context "converter" do
    it "should convert 1 to one" do
        post(:index, { :number => 1 } )
        response.body.should =~ /one/m
    end

    it "should convert the incoming 41 to fourtyone" do
      post(:index, { :number => 41 } )
      response.body.should =~ /fourtyone/m
    end

    it "should convert the examples to words" do
      # [ 8050, "eight thousand and fifty" ]
      [ [ 1, "one" ], [ 12, "twelve" ], [ 56, "fiftysix" ], [ 111, "onehundred eleven" ] ].each do |example| 
        post(:index, { :number => example[0] } )
        response.body.should =~ /#{example[1]}/m
      end
    end

  end

end
