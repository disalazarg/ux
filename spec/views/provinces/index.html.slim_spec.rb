require 'rails_helper'

RSpec.describe "provinces/index", type: :view do
  before(:each) do
    assign(:provinces, [
      Province.create!(
        :region => nil,
        :name => "Name",
        :lat => "9.99",
        :lng => "9.99",
        :slug => "Slug"
      ),
      Province.create!(
        :region => nil,
        :name => "Name",
        :lat => "9.99",
        :lng => "9.99",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of provinces" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
