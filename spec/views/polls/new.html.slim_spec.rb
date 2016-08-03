require 'rails_helper'

RSpec.describe "polls/new", type: :view do
  before(:each) do
    assign(:poll, Poll.new(
      :product => nil,
      :title => "MyString",
      :intro => "MyText",
      :slug => "MyString"
    ))
  end

  it "renders new poll form" do
    render

    assert_select "form[action=?][method=?]", polls_path, "post" do

      assert_select "input#poll_product_id[name=?]", "poll[product_id]"

      assert_select "input#poll_title[name=?]", "poll[title]"

      assert_select "textarea#poll_intro[name=?]", "poll[intro]"

      assert_select "input#poll_slug[name=?]", "poll[slug]"
    end
  end
end
