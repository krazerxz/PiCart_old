json.array!(@products) do |product|
  json.extract! product, :id, :title, :image, :details_found, :barcode
  json.url product_url(product, format: :json)
end
