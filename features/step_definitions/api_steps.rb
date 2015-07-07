When 'I post a barcode to the product api' do
  post 'api/products/', upc: 123_456_789_012
end

Then 'a product is saved in the database' do
  expect(Product.all.first.barcode).to eq '123456789012'
end
