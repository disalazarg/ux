require 'rails_helper'

RSpec.describe "contacts/new", type: :view do
  before(:each) do
    assign(:contact, Contact.new(
      :school => nil,
      :email => "MyString",
      :name => "MyString",
      :rbd => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input#contact_school_id[name=?]", "contact[school_id]"

      assert_select "input#contact_email[name=?]", "contact[email]"

      assert_select "input#contact_name[name=?]", "contact[name]"

      assert_select "input#contact_rbd[name=?]", "contact[rbd]"

      assert_select "input#contact_slug[name=?]", "contact[slug]"
    end
  end
end
