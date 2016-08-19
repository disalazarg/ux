require 'rails_helper'

RSpec.describe "picks/index", type: :view do
  before(:each) do
    assign(:picks, [
      Pick.create!(
        :answer => nil,
        :alternative => nil
      ),
      Pick.create!(
        :answer => nil,
        :alternative => nil
      )
    ])
  end

  it "renders a list of picks" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
