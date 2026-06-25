class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_owner
  def index
    @store = current_user.stores.find_by(id:params[:store_id])
    redirect_to stores_path, alert: "Store not found" and return unless @store
    @products = @store.products
    @orders = @store.orders
    @total_orders = @orders.count
    @pending_orders = @orders.where(status: "pending").count
    @cancelled_orders = @orders.where(status: "cancelled").count
    @revenue = @orders.where.not(status: "cancelled").sum do |order|
      order.product.price * order.quantity
    end
    
  end

  def ensure_owner
    redirect_to root_path unless current_user.ensure_owner?
    ebd
end
