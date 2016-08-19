require 'rails_helper'

RSpec.describe "answers/edit", type: :view do
  before(:each) do
    @answer = assign(:answer, Answer.create!(
      :contact => nil,
      :product => nil
    ))
  end

  it "renders the edit answer form" do
    render

    assert_select "form[action=?][method=?]", answer_path(@answer), "post" do

      assert_select "input#answer_contact_id[name=?]", "answer[contact_id]"

      assert_select "input#answer_product_id[name=?]", "answer[product_id]"
    end
  end
end
