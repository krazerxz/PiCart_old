require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :title => "Title",
        :image => "Image",
        :details_found => false,
        :barcode => "Barcode"
      ),
      Product.create!(
        :title => "Title",
        :image => "Image",
        :details_found => false,
        :barcode => "Barcode"
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Barcode".to_s, :count => 2
  end
end
