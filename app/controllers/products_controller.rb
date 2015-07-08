class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :create

  def index
    @products = Product.all
  end

  def show
    # @product
  end

  def new
    @product = Product.new
  end

  def edit
    # @product
  end

  def create
    resolve product_params[:barcode]

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def resolve(barcode)
    barcode = barcode.match(/0*(\w+)/)[1]
    fail BarcodeException if barcode =~ /\D/
    @product = Product.find_by(barcode: barcode)
    @product = SearchUPCWraper.new.get_product_for(barcode) if @product.nil?
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :image, :details_found, :barcode)
  end
end
