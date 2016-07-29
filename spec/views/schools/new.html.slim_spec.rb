require 'rails_helper'

RSpec.describe "schools/new", type: :view do
  before(:each) do
    assign(:school, School.new(
      :district => nil,
      :name => "MyString",
      :statute => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders new school form" do
    render

    assert_select "form[action=?][method=?]", schools_path, "post" do

      assert_select "input#school_district_id[name=?]", "school[district_id]"

      assert_select "input#school_name[name=?]", "school[name]"

      assert_select "input#school_statute[name=?]", "school[statute]"

      assert_select "input#school_slug[name=?]", "school[slug]"
    end
  end
end
