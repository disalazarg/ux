require 'rails_helper'

RSpec.describe "schools/edit", type: :view do
  before(:each) do
    @school = assign(:school, School.create!(
      :district => nil,
      :name => "MyString",
      :statute => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit school form" do
    render

    assert_select "form[action=?][method=?]", school_path(@school), "post" do

      assert_select "input#school_district_id[name=?]", "school[district_id]"

      assert_select "input#school_name[name=?]", "school[name]"

      assert_select "input#school_statute[name=?]", "school[statute]"

      assert_select "input#school_slug[name=?]", "school[slug]"
    end
  end
end
