require 'rails_helper'

describe Api::BarcodesController, type: :controller do
  describe '#create' do
    it 'should create a Barcode with the given UPC' do
      expect(Barcode).to receive(:create).with('upc' => '87654321')
      # Api::BarcodesController.create({ upc: 87654321 })
      post :create, upc: '87654321'
    end

    it do
      should permit(:upc).for(:create, params: { 'upc' => '123456789012' })
    end
  end
end
