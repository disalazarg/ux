require 'rails_helper'

RSpec.describe "contacts/edit", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :school => nil,
      :email => "MyString",
      :name => "MyString",
      :rbd => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit contact form" do
    render

    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do

      assert_select "input#contact_school_id[name=?]", "contact[school_id]"

      assert_select "input#contact_email[name=?]", "contact[email]"

      assert_select "input#contact_name[name=?]", "contact[name]"

      assert_select "input#contact_rbd[name=?]", "contact[rbd]"

      assert_select "input#contact_slug[name=?]", "contact[slug]"
    end
  end
end
