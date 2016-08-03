require 'rails_helper'

RSpec.describe "educations/new", type: :view do
  before(:each) do
    assign(:education, Education.new(
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders new education form" do
    render

    assert_select "form[action=?][method=?]", educations_path, "post" do

      assert_select "input#education_name[name=?]", "education[name]"

      assert_select "input#education_slug[name=?]", "education[slug]"
    end
  end
end
