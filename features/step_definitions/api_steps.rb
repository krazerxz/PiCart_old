When 'I post a barcode to the api' do
  post 'api/barcodes/', upc: 123_456_789_012
end

Then 'a barcode is saved in the database' do
  expect(Barcode.all.first.upc).to eq 123_456_789_012
end

And 'the barcode is resolved to a product' do
  resolved_product = Product.where(upc: 123_456_789_012)
  expect(resolved_product.upc).to eq 123_456_789_012
end

Then 'the barcode is removed' do
  expect(Barcode.all.count).to eq 0
end
