require 'rails_helper'

RSpec.describe "regions/new", type: :view do
  before(:each) do
    assign(:region, Region.new(
      :code => "MyString",
      :name => "MyString",
      :lat => "9.99",
      :lng => "9.99",
      :slug => "MyString"
    ))
  end

  it "renders new region form" do
    render

    assert_select "form[action=?][method=?]", regions_path, "post" do

      assert_select "input#region_code[name=?]", "region[code]"

      assert_select "input#region_name[name=?]", "region[name]"

      assert_select "input#region_lat[name=?]", "region[lat]"

      assert_select "input#region_lng[name=?]", "region[lng]"

      assert_select "input#region_slug[name=?]", "region[slug]"
    end
  end
end
