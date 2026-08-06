class CartsController < ApplicationController
 

  def show
    @cart = current_cart
  end

  def apply_coupon
    @cart = current_cart
    coupon = current_store.coupons.find_by(code: params[:code].to_s.strip.upcase)

    if coupon.nil?
      @cart_error = "Invalid coupon code"
    elsif !coupon.valid_now?
      @cart_error = "This coupon is no longer valid"
    elsif !coupon.meets_minimum?(@cart.subtotal)
      @cart_error = "Minimum order of €#{coupon.minimum_order_amount} required"
    else
      @cart.update(coupon: coupon)
    end

      render turbo_stream: turbo_stream.replace("cart",
      partial: "carts/cart",
      locals: { cart: @cart, cart_error: @cart_error })
  end

  def remove_coupon
    @cart = current_cart
    @cart.update(coupon: nil)

    render turbo_stream: turbo_stream.replace("cart",
    partial: "carts/cart",
    locals: { cart: @cart, cart_error: nil })
  end
end
