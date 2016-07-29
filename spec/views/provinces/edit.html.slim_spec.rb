require 'rails_helper'

RSpec.describe "provinces/edit", type: :view do
  before(:each) do
    @province = assign(:province, Province.create!(
      :region => nil,
      :name => "MyString",
      :lat => "9.99",
      :lng => "9.99",
      :slug => "MyString"
    ))
  end

  it "renders the edit province form" do
    render

    assert_select "form[action=?][method=?]", province_path(@province), "post" do

      assert_select "input#province_region_id[name=?]", "province[region_id]"

      assert_select "input#province_name[name=?]", "province[name]"

      assert_select "input#province_lat[name=?]", "province[lat]"

      assert_select "input#province_lng[name=?]", "province[lng]"

      assert_select "input#province_slug[name=?]", "province[slug]"
    end
  end
end
