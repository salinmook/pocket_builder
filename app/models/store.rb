class Store < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :orders
  has_one_attached :logo
  has_one_attached :banner
  has_many :categories, dependent: :destroy
  has_many :coupons, dependent: :destroy
  
  validates :name, presence: true
end
