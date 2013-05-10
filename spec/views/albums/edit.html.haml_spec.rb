require 'spec_helper'

describe "albums/edit" do
  before(:each) do
    @album = assign(:album, stub_model(Album,
      :name => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit album form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", album_path(@album), "post" do
      assert_select "input#album_name[name=?]", "album[name]"
      assert_select "input#album_user_id[name=?]", "album[user_id]"
    end
  end
end
