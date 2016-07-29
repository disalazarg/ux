require 'rails_helper'

RSpec.describe "regions/index", type: :view do
  before(:each) do
    assign(:regions, [
      Region.create!(
        :code => "Code",
        :name => "Name",
        :lat => "9.99",
        :lng => "9.99",
        :slug => "Slug"
      ),
      Region.create!(
        :code => "Code",
        :name => "Name",
        :lat => "9.99",
        :lng => "9.99",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of regions" do
    render
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
