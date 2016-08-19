require 'rails_helper'

RSpec.describe "picks/new", type: :view do
  before(:each) do
    assign(:pick, Pick.new(
      :answer => nil,
      :alternative => nil
    ))
  end

  it "renders new pick form" do
    render

    assert_select "form[action=?][method=?]", picks_path, "post" do

      assert_select "input#pick_answer_id[name=?]", "pick[answer_id]"

      assert_select "input#pick_alternative_id[name=?]", "pick[alternative_id]"
    end
  end
end
