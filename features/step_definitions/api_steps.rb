When 'I post a barcode to the api' do
  post 'api/barcodes/', upc: 123_456_789_012
end

Then 'a barcode is saved in the database' do
  expect(Barcode.all.first.upc).to eq 123_456_789_012
end
