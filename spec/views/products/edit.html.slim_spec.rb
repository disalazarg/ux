require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :user => nil,
      :name => "MyString",
      :link => "MyString",
      :description => "MyText",
      :slug => "MyString"
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_user_id[name=?]", "product[user_id]"

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_link[name=?]", "product[link]"

      assert_select "textarea#product_description[name=?]", "product[description]"

      assert_select "input#product_slug[name=?]", "product[slug]"
    end
  end
end
