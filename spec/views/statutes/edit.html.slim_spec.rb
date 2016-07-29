require 'rails_helper'

RSpec.describe "statutes/edit", type: :view do
  before(:each) do
    @statute = assign(:statute, Statute.create!(
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit statute form" do
    render

    assert_select "form[action=?][method=?]", statute_path(@statute), "post" do

      assert_select "input#statute_name[name=?]", "statute[name]"

      assert_select "input#statute_slug[name=?]", "statute[slug]"
    end
  end
end
