When 'I post a barcode to the api' do
  visit 'api/barcodes/new?barcode=12345678'
end

Then 'a barcode is saved in the database' do
  expect(true).to be false
end
