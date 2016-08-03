require 'rails_helper'

RSpec.describe "educations/index", type: :view do
  before(:each) do
    assign(:educations, [
      Education.create!(
        :name => "Name",
        :slug => "Slug"
      ),
      Education.create!(
        :name => "Name",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of educations" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
