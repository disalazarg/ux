require 'rails_helper'

RSpec.describe "picks/show", type: :view do
  before(:each) do
    @pick = assign(:pick, Pick.create!(
      :answer => nil,
      :alternative => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
