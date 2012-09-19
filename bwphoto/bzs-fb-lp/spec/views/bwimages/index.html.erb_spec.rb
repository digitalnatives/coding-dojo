require 'spec_helper'

describe "bwimages/index" do
  before(:each) do
    assign(:bwimages, [
      stub_model(Bwimage,
        :name => "Name",
        :camera => "Camera",
        :author => "Author",
        :url => "Url"
      ),
      stub_model(Bwimage,
        :name => "Name",
        :camera => "Camera",
        :author => "Author",
        :url => "Url"
      )
    ])
  end

  it "renders a list of bwimages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Camera".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
