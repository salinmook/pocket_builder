class CartsController < ApplicationController
  def show
    @cart = Cart.find_or_create_by(store: current_store)
  end
end
