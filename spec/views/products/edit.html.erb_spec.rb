require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :title => "MyString",
      :image => "MyString",
      :details_found => false,
      :barcode => "MyString"
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_title[name=?]", "product[title]"

      assert_select "input#product_image[name=?]", "product[image]"

      assert_select "input#product_details_found[name=?]", "product[details_found]"

      assert_select "input#product_barcode[name=?]", "product[barcode]"
    end
  end
end
