require 'rails_helper'

RSpec.describe "educations/edit", type: :view do
  before(:each) do
    @education = assign(:education, Education.create!(
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit education form" do
    render

    assert_select "form[action=?][method=?]", education_path(@education), "post" do

      assert_select "input#education_name[name=?]", "education[name]"

      assert_select "input#education_slug[name=?]", "education[slug]"
    end
  end
end
