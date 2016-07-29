require 'rails_helper'

RSpec.describe "statutes/index", type: :view do
  before(:each) do
    assign(:statutes, [
      Statute.create!(
        :name => "Name",
        :slug => "Slug"
      ),
      Statute.create!(
        :name => "Name",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of statutes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
