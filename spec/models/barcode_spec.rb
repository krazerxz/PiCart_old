require 'rails_helper'

describe Barcode, type: :model do
  describe '.save' do
    it 'should save a barcode with a valid upc' do
      Barcode.create(upc: 123_456_789_012)
      expect(Barcode.all.count).to eq 1
    end
    it 'should fail if a valid upc is not given' do
      expect { Barcode.create(upc: 'not_a_upc') }.to raise_error(BarcodeException, 'Upc is invalid')
      expect { Barcode.create(upc: '123456789') }.to raise_error(BarcodeException, 'Upc is invalid') # UPCs are 12 digits
      expect { Barcode.create(upc: '1234567890123') }.to raise_error(BarcodeException, 'Upc is invalid') # UPCs are 12 digits
    end
  end
end
