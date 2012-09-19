require 'spec_helper'

describe "bwimages/edit" do
  before(:each) do
    @bwimage = assign(:bwimage, stub_model(Bwimage,
      :name => "MyString",
      :camera => "MyString",
      :author => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit bwimage form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bwimages_path(@bwimage), :method => "post" do
      assert_select "input#bwimage_name", :name => "bwimage[name]"
      assert_select "input#bwimage_camera", :name => "bwimage[camera]"
      assert_select "input#bwimage_author", :name => "bwimage[author]"
      assert_select "input#bwimage_url", :name => "bwimage[url]"
    end
  end
end
