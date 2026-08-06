class Cart < ApplicationRecord
    belongs_to :store
    belongs_to :customer, optional: true
    belongs_to :coupon, optional: true
    has_many :cart_items, dependent: :destroy

    def subtotal
        cart_items.sum { |item| item.product.price * item.quantity }
    end
    def discount_amount
        return 0 unless coupon
        coupon.discount_amount(subtotal)
    end

    def total
        subtotal - discount_amount
    end
end 
