require 'rails_helper'

RSpec.describe "districts/index", type: :view do
  before(:each) do
    assign(:districts, [
      District.create!(
        :province => nil,
        :name => "Name",
        :lat => "9.99",
        :lng => "9.99",
        :slug => "Slug"
      ),
      District.create!(
        :province => nil,
        :name => "Name",
        :lat => "9.99",
        :lng => "9.99",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of districts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
