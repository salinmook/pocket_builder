class Order < ApplicationRecord
  belongs_to :store
  belongs_to :customer, optional: true
  belongs_to :coupon, optional: true
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
end
