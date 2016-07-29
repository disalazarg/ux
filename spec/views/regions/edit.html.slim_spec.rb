require 'rails_helper'

RSpec.describe "regions/edit", type: :view do
  before(:each) do
    @region = assign(:region, Region.create!(
      :code => "MyString",
      :name => "MyString",
      :lat => "9.99",
      :lng => "9.99",
      :slug => "MyString"
    ))
  end

  it "renders the edit region form" do
    render

    assert_select "form[action=?][method=?]", region_path(@region), "post" do

      assert_select "input#region_code[name=?]", "region[code]"

      assert_select "input#region_name[name=?]", "region[name]"

      assert_select "input#region_lat[name=?]", "region[lat]"

      assert_select "input#region_lng[name=?]", "region[lng]"

      assert_select "input#region_slug[name=?]", "region[slug]"
    end
  end
end
