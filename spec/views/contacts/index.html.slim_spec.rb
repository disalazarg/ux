require 'rails_helper'

RSpec.describe "contacts/index", type: :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
        :school => nil,
        :email => "Email",
        :name => "Name",
        :rbd => "Rbd",
        :slug => "Slug"
      ),
      Contact.create!(
        :school => nil,
        :email => "Email",
        :name => "Name",
        :rbd => "Rbd",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Rbd".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
