class BarcodeException < Exception; end

class Barcode < ActiveRecord::Base
  validates :upc, format: { with: /\A\d{1,13}\z/ }, strict: BarcodeException
end
