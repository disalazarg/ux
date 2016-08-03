require 'rails_helper'

RSpec.describe "educations/show", type: :view do
  before(:each) do
    @education = assign(:education, Education.create!(
      :name => "Name",
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Slug/)
  end
end
