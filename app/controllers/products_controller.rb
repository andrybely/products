class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]

  before_action :set_product, only: [:show]

  before_action :set_current_user_product, only: [:edit, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
    @new_photo = @product.photos.build(params[:photo])
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = current_user.products.build(product_params)

    if @product.save
      redirect_to @product, notice: 'Продукт успешно создан'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Продукт успешно обновлен'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Продукт успешно удален'
  end

  private

  def set_current_user_product
    @product = current_user.products.find(params[:id])
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:title, :description)
    end
end
