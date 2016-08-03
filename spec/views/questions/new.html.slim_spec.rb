require 'rails_helper'

RSpec.describe "questions/new", type: :view do
  before(:each) do
    assign(:question, Question.new(
      :poll => nil,
      :statement => "MyText"
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "input#question_poll_id[name=?]", "question[poll_id]"

      assert_select "textarea#question_statement[name=?]", "question[statement]"
    end
  end
end
