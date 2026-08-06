class ApplicationController < ActionController::Base
  before_action :set_store

  helper_method :current_store, :current_cart
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def after_sign_in_path_for(resource)
    if resource.is_a?(Customer)
      store_path(resource.store)
    else
      super
    end
  end

  private
  def set_store
    if params[:store_id]
      session[:store_id] = params[:store_id]
    elsif params[:id] && controller_name == "stores"
      session[:store_id] = params[:id]
    end
    @current_store = Store.find_by(id: session[:store_id])
  end

  def current_store
    @current_store ||= Store.find_by(id: session[:store_id])
  end

  def current_cart
    return nil unless current_store
    if customer_signed_in?
      cart = Cart.find_or_create_by(store: current_store, customer: current_customer)
      merge_guest_cart_into(cart)
      cart
    else
      cart = Cart.find_by(id: session[:guest_cart_id], store: current_store)
      unless cart
        cart = Cart.create!(store: current_store)
        session[:guest_cart_id] = cart.id
      end
      cart
    end
  end

  def merge_guest_cart_into(customer_cart)
    guest_cart_id = session[:guest_cart_id]
    return unless guest_cart_id
    guest_cart = Cart.find_by(id: guest_cart_id, store: current_store, customer: nil)
    return unless guest_cart && guest_cart.id != customer_cart.id

    guest_cart.cart_items.each do |item|
      existing = customer_cart.cart_items.find_by(product_id: item.product_id)
      if existing
        existing.increment!(:quantity, item.quantity)
      else
        item.update!(cart: customer_cart)
      end
    end
    guest_cart.reload.destroy
    session[:guest_cart_id] = nil
  end
    

  def require_customer_login!
    unless customer_signed_in?
      redirect_to store_new_customer_session_path(current_store), alert: "Please login to continue"
    end
  end
end
