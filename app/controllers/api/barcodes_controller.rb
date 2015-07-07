class Api::BarcodesController < ApplicationController
  protect_from_forgery except: :create

  def create
    upc_code = barcode_params[:upc].match(/0*(\w+)/)[1]
    fail BarcodeException if upc_code =~ /\D/
    Barcode.create('upc' => upc_code)
    # resolve barcode
    render nothing: true
  end

  private

  def barcode_params
    params.permit(:upc)
  end
end
