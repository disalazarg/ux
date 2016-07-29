require 'rails_helper'

RSpec.describe "provinces/new", type: :view do
  before(:each) do
    assign(:province, Province.new(
      :region => nil,
      :name => "MyString",
      :lat => "9.99",
      :lng => "9.99",
      :slug => "MyString"
    ))
  end

  it "renders new province form" do
    render

    assert_select "form[action=?][method=?]", provinces_path, "post" do

      assert_select "input#province_region_id[name=?]", "province[region_id]"

      assert_select "input#province_name[name=?]", "province[name]"

      assert_select "input#province_lat[name=?]", "province[lat]"

      assert_select "input#province_lng[name=?]", "province[lng]"

      assert_select "input#province_slug[name=?]", "province[slug]"
    end
  end
end
