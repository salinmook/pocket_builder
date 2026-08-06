class AddCouponToCartsAndOrders < ActiveRecord::Migration[8.1]
  def change
    add_reference :carts, :coupon, foreign_key: true, null: true
    add_reference :orders, :coupon, foreign_key: true, null: true
    add_column :orders, :discount_amount, :decimal, precision: 10, scale: 2, default: 0, null: false
  end
end
