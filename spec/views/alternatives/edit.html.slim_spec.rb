require 'rails_helper'

RSpec.describe "alternatives/edit", type: :view do
  before(:each) do
    @alternative = assign(:alternative, Alternative.create!(
      :question => nil,
      :number => 1,
      :statement => "MyText"
    ))
  end

  it "renders the edit alternative form" do
    render

    assert_select "form[action=?][method=?]", alternative_path(@alternative), "post" do

      assert_select "input#alternative_question_id[name=?]", "alternative[question_id]"

      assert_select "input#alternative_number[name=?]", "alternative[number]"

      assert_select "textarea#alternative_statement[name=?]", "alternative[statement]"
    end
  end
end
