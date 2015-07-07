class Api::ProductsController < ApplicationController
  protect_from_forgery except: :create

  def index
    @products = Product.all
  end

  def create
    upc_code = barcode_params[:upc].match(/0*(\w+)/)[1]
    fail BarcodeException if upc_code =~ /\D/
    SearchUPCWraper.new.get_product_for(upc_code)
    render nothing: true
  end

  private

  def barcode_params
    params.permit(:upc)
  end
end
