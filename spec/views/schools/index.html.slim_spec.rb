require 'rails_helper'

RSpec.describe "schools/index", type: :view do
  before(:each) do
    assign(:schools, [
      School.create!(
        :district => nil,
        :name => "Name",
        :statute => "Statute",
        :slug => "Slug"
      ),
      School.create!(
        :district => nil,
        :name => "Name",
        :statute => "Statute",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of schools" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Statute".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
