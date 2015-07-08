require 'rails_helper'

describe Api::ProductsController, type: :controller do
  describe '#create' do
    let(:search_upc_wrapper) { double(:search_upc_wrapper) }

    before do
      allow(SearchUPCWraper).to receive(:new).and_return(search_upc_wrapper)
    end

    it 'should raise a BarcodeException if the upc contains a word character' do
      expect do
        post :create, upc: '54321_text'
      end.to raise_error(BarcodeException)
    end

    context 'a product with the given upc exists in the local database' do
      let(:local_product) { 'a_product' }

      before do
        allow(Product).to receive(:find_by).with(barcode: '87654321').and_return local_product
      end

      it 'should check the local product database for the given UPC' do
        expect(Product).to receive(:find_by).with(barcode: '87654321')
        post :create, upc: '87654321'
      end
    end

    context 'a product with the given upc could not be found in the local database' do
      before do
        allow(Product).to receive(:find_by).with(barcode: '87654321').and_return nil
      end

      it 'should strip leading zeros' do
        expect(search_upc_wrapper).to receive(:get_product_for).with('87654321')
        post :create, upc: '0087654321'
      end
      it 'should resolve the product for the given UPC' do
        expect(search_upc_wrapper).to receive(:get_product_for).with('87654321')
        post :create, upc: '87654321'
      end

      it do
        allow(Product).to receive(:find_by).with(barcode: '123456789012').and_return nil
        allow(search_upc_wrapper).to receive(:get_product_for).with('123456789012')
        should permit(:upc).for(:create, params: { 'upc' => '123456789012' })
      end
    end
  end
end
