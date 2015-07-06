require 'rails_helper'

describe SemanticsWrapper do
  describe '.product' do
    let(:semantics_credentials) { { 'semantics_api_key' => 'key', 'semantics_api_secret' => 'hush-hush' } }
    let(:semantic_product)      { {} }
    let(:semantics_instance)    { double(:semantics_products, products_field: {}, get_products: semantic_product) }

    before do
      allow(YAML).to receive(:load_file).and_return(semantics_credentials)
      allow(Semantics3::Products).to receive(:new).with('key', 'hush-hush').and_return(semantics_instance)
    end

    it 'should initialize the semantics_wrapper' do
      expect(Semantics3::Products).to receive(:new).with('key', 'hush-hush')
      SemanticsWrapper.new.resolve(12_345)
    end

    xit 'should return a product' do
      expect(SemanticsWrapper.new.resolve(12_345)).to eq('an_actual_product')
    end
  end
end
