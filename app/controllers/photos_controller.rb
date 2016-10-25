class PhotosController < ApplicationController

  before_action :set_product, only: [:create, :destroy]
  before_action :set_photo, only: [:destroy]

  def create
    @new_photo = @product.photos.build(photo_params)
    @new_photo.user = current_user

    if @new_photo.save
      redirect_to @product, notice: 'Фотография успешно добавлена'
    else
      render 'products/show', alert: 'Произошла ошибка'
    end
  end

  def destroy
    message = 'Фотография успешно удалена'

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = 'Произошла ошибка'
    end

    redirect_to @product, message
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_photo
      @photo = @product.photos.find(params[:id])
    end

    def photo_params
      params.fetch(:photo, {}).permit(:photo)
    end
end
