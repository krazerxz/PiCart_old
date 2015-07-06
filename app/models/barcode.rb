class BarcodeException < Exception; end

class Barcode < ActiveRecord::Base
  validates :upc, format: { with: /\A\d{12}\z/ }, strict: BarcodeException
end
