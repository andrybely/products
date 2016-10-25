class Product < ApplicationRecord

  validates :title, presence: true, length: {maximum: 255}

end