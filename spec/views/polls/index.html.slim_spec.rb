require 'rails_helper'

RSpec.describe "polls/index", type: :view do
  before(:each) do
    assign(:polls, [
      Poll.create!(
        :product => nil,
        :title => "Title",
        :intro => "MyText",
        :slug => "Slug"
      ),
      Poll.create!(
        :product => nil,
        :title => "Title",
        :intro => "MyText",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of polls" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
