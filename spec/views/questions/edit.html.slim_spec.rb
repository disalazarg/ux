require 'rails_helper'

RSpec.describe "questions/edit", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :poll => nil,
      :statement => "MyText"
    ))
  end

  it "renders the edit question form" do
    render

    assert_select "form[action=?][method=?]", question_path(@question), "post" do

      assert_select "input#question_poll_id[name=?]", "question[poll_id]"

      assert_select "textarea#question_statement[name=?]", "question[statement]"
    end
  end
end
