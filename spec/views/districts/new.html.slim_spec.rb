require 'rails_helper'

RSpec.describe "districts/new", type: :view do
  before(:each) do
    assign(:district, District.new(
      :province => nil,
      :name => "MyString",
      :lat => "9.99",
      :lng => "9.99",
      :slug => "MyString"
    ))
  end

  it "renders new district form" do
    render

    assert_select "form[action=?][method=?]", districts_path, "post" do

      assert_select "input#district_province_id[name=?]", "district[province_id]"

      assert_select "input#district_name[name=?]", "district[name]"

      assert_select "input#district_lat[name=?]", "district[lat]"

      assert_select "input#district_lng[name=?]", "district[lng]"

      assert_select "input#district_slug[name=?]", "district[slug]"
    end
  end
end
