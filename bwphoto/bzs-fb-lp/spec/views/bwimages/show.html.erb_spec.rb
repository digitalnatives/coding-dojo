require 'spec_helper'

describe "bwimages/show" do
  before(:each) do
    @bwimage = assign(:bwimage, stub_model(Bwimage,
      :name => "Name",
      :camera => "Camera",
      :author => "Author",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Camera/)
    rendered.should match(/Author/)
    rendered.should match(/Url/)
  end
end
