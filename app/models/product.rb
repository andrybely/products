class Product < ApplicationRecord

  belongs_to :user
  has_many :photos


  validates :user, presence: true
  validates :title, presence: true, length: {maximum: 255}

end
