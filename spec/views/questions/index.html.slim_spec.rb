require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :poll => nil,
        :statement => "MyText"
      ),
      Question.create!(
        :poll => nil,
        :statement => "MyText"
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
