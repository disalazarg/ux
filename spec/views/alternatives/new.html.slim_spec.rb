require 'rails_helper'

RSpec.describe "alternatives/new", type: :view do
  before(:each) do
    assign(:alternative, Alternative.new(
      :question => nil,
      :number => 1,
      :statement => "MyText"
    ))
  end

  it "renders new alternative form" do
    render

    assert_select "form[action=?][method=?]", alternatives_path, "post" do

      assert_select "input#alternative_question_id[name=?]", "alternative[question_id]"

      assert_select "input#alternative_number[name=?]", "alternative[number]"

      assert_select "textarea#alternative_statement[name=?]", "alternative[statement]"
    end
  end
end
