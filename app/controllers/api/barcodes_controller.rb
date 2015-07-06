class Api::BarcodesController < ApplicationController
   protect_from_forgery :except => :create

  def create
    Barcode.create(barcode_params)
    render nothing: true
  end

  private

  def barcode_params
    params.permit(:upc)
  end
end
