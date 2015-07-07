require 'rails_helper'

describe SearchUPCWraper do
  describe '.get_product_for' do
    let(:search_page) { double(:search_page) }
    let(:mechanize) { double(:mechanize) }
    let(:search_form) { double(:search_form, button_with: nil, click_button: results_page) }
    let(:search_box_string) { double(:search_box_string, value: 'placeholder') }

    before do
      allow(Mechanize).to receive(:new).and_return(mechanize)
      allow(mechanize).to receive(:get).with('http://www.searchupc.com').and_return(search_page)
      allow(search_page).to receive(:form_with).with(name: 'searchupc').and_return(search_form)
      allow(search_form).to receive(:field_with).with('q').and_return(search_box_string)
      allow(search_box_string).to receive(:value=)
    end

    context 'a valid upc code' do
      let(:link_1) { OpenStruct.new('text' => 'some_random_text') }
      let(:link_2) { OpenStruct.new('text' => 'product_name') }
      let(:links) { [link_1, link_2] }
      let(:image_1) { OpenStruct.new('title' => 'not_the_one_we_want') }
      let(:image_2) { OpenStruct.new('title' => 'Product Image', 'url' => 'the_image_url') }
      let(:images) { [image_1, image_2] }
      let(:results_page) { double(:results_page, links: links, images: images) }

      it 'should send the UPC code to the website' do
        expect(search_box_string).to receive(:value=).with('a_upc')
        SearchUPCWraper.new.get_product_for('a_upc')
      end

      it 'should return a completed product if details were found' do
        product = SearchUPCWraper.new.get_product_for('a_upc')
        expect(product.barcode).to eq 'a_upc'
        expect(product.title).to eq 'product_name'
        expect(product.image).to eq 'the_image_url'
        expect(product.details_found).to be true
      end
    end

    context 'an invalid upc code' do
      let(:results_page) { double(:results_page, images: []) }
      it 'should return an empty product if the barcode could not be resolved' do
        product = SearchUPCWraper.new.get_product_for('an_unresolvable_upc')
        expect(product.barcode).to eq 'an_unresolvable_upc'
        expect(product.title).to be nil
        expect(product.image).to be nil
        expect(product.details_found).to be false
      end
    end
  end
end
