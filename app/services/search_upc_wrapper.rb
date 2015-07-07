require 'mechanize'

class SearchUPCWraper
  def initialize
    @mechanize = Mechanize.new
  end

  def get_product_for(upc_code)
    result = fill_upc_form_with upc_code
    images = result.images.select { |image| image.title == 'Product Image' }
    return Product.create(barcode: upc_code) if images.empty?
    title = result.links[1].text
    url = images.first.url
    Product.create(title: title, image: url, details_found: true, barcode: upc_code)
  end

  private

  def fill_upc_form_with(code)
    page =  @mechanize.get('http://www.searchupc.com')
    upc_form = page.form_with(name: 'searchupc')
    upc_form.field_with('q').value = code
    upc_form.click_button(upc_form.button_with(name: 'search'))
  end
end
