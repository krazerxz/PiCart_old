require 'rails_helper'

describe Barcode, type: :model do
  describe '.save' do
    it 'should save a barcode with a valid upc' do
      Barcode.create(upc: '123_456_789_0123')
      Barcode.create(upc: '456_789_012')
      expect(Barcode.all.count).to eq 2
    end

    xit 'should fail if a valid upc is not given' do
      expect { Barcode.create(upc: '12345678901234') }.to raise_error(BarcodeException, 'Upc is invalid') # UPCs are at most 13 digits
      expect { Barcode.create(upc: 'nope123') }.to raise_error(BarcodeException, 'Upc is invalid') # UPCs are at most 13 digits
      expect { Barcode.create(upc: 'not_a_upc') }.to raise_error(BarcodeException, 'Upc is invalid')
    end
  end
end
