module ApplicationHelper
  def product_photo(product)
    photos = product.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path('product.jpg')
    end
  end

  def product_thumb(product)
    photos = product.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path('product_thumb.jpg')
    end
  end
end
