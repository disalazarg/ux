require 'rails_helper'

RSpec.describe "alternatives/show", type: :view do
  before(:each) do
    @alternative = assign(:alternative, Alternative.create!(
      :question => nil,
      :number => 2,
      :statement => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
