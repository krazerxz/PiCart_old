require 'rails_helper'

describe ProductsController, type: :controller do
  describe '#create' do
    let(:search_upc_wrapper) { double(:search_upc_wrapper) }
    let(:product) { double(:product, save: nil) }

    before do
      allow(SearchUPCWraper).to receive(:new).and_return(search_upc_wrapper)
      allow(Product).to receive(:find_by).with(barcode: '87654321').and_return product
    end

    it 'should raise a BarcodeException if the barcode contains a word character' do
      expect do
        post :create, product: { barcode: '54321_text' }
      end.to raise_error(BarcodeException)
    end

    context 'a product with the given barcode exists in the local database' do
      it 'should check the local product database for the given barcode' do
        expect(Product).to receive(:find_by).with(barcode: '87654321')
        post :create, product: { barcode: '87654321' }
      end
    end

    context 'a product with the given barcode could not be found in the local database' do
      before do
        allow(Product).to receive(:find_by).with(barcode: '87654321').and_return nil
        allow(search_upc_wrapper).to receive(:get_product_for).with('87654321').and_return(product)
      end

      it 'should strip leading zeros' do
        expect(search_upc_wrapper).to receive(:get_product_for).with('87654321')
        post :create, product: { barcode: '0087654321' }
      end
      it 'should resolve the product for the given barcode' do
        expect(search_upc_wrapper).to receive(:get_product_for).with('87654321')
        post :create, product: { barcode: '87654321' }
      end

      it do
        allow(Product).to receive(:find_by).with(barcode: '123456789012').and_return product
        should permit(:barcode).for(:create, params: { 'barcode' => '123456789012' })
      end
    end
  end
end
