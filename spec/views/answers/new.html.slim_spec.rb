require 'rails_helper'

RSpec.describe "answers/new", type: :view do
  before(:each) do
    assign(:answer, Answer.new(
      :contact => nil,
      :product => nil
    ))
  end

  it "renders new answer form" do
    render

    assert_select "form[action=?][method=?]", answers_path, "post" do

      assert_select "input#answer_contact_id[name=?]", "answer[contact_id]"

      assert_select "input#answer_product_id[name=?]", "answer[product_id]"
    end
  end
end
