require 'rails_helper'

RSpec.describe "picks/edit", type: :view do
  before(:each) do
    @pick = assign(:pick, Pick.create!(
      :answer => nil,
      :alternative => nil
    ))
  end

  it "renders the edit pick form" do
    render

    assert_select "form[action=?][method=?]", pick_path(@pick), "post" do

      assert_select "input#pick_answer_id[name=?]", "pick[answer_id]"

      assert_select "input#pick_alternative_id[name=?]", "pick[alternative_id]"
    end
  end
end
