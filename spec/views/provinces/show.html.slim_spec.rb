require 'rails_helper'

RSpec.describe "provinces/show", type: :view do
  before(:each) do
    @province = assign(:province, Province.create!(
      :region => nil,
      :name => "Name",
      :lat => "9.99",
      :lng => "9.99",
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Slug/)
  end
end
