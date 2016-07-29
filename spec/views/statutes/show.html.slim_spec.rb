require 'rails_helper'

RSpec.describe "statutes/show", type: :view do
  before(:each) do
    @statute = assign(:statute, Statute.create!(
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
