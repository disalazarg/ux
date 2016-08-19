require 'rails_helper'

RSpec.describe "alternatives/index", type: :view do
  before(:each) do
    assign(:alternatives, [
      Alternative.create!(
        :question => nil,
        :number => 2,
        :statement => "MyText"
      ),
      Alternative.create!(
        :question => nil,
        :number => 2,
        :statement => "MyText"
      )
    ])
  end

  it "renders a list of alternatives" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
