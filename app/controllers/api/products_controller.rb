class Api::ProductsController < ApplicationController
  protect_from_forgery except: :create

  def create
    upc_code = barcode_params[:upc].match(/0*(\w+)/)[1]
    fail BarcodeException if upc_code =~ /\D/
    product = Product.find_by(barcode: upc_code)
    SearchUPCWraper.new.get_product_for(upc_code) if product.nil?
    render nothing: true
  end

  private

  def barcode_params
    params.permit(:upc)
  end
end
