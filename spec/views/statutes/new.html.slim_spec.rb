require 'rails_helper'

RSpec.describe "statutes/new", type: :view do
  before(:each) do
    assign(:statute, Statute.new(
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders new statute form" do
    render

    assert_select "form[action=?][method=?]", statutes_path, "post" do

      assert_select "input#statute_name[name=?]", "statute[name]"

      assert_select "input#statute_slug[name=?]", "statute[slug]"
    end
  end
end
