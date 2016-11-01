class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  #has_many :assignments
  #has_many :roles, through: :assignments

 validates :name, presence: true, length: {maximum: 35}

  def role?
    role
  end


end
