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
    @shipped_orders = @orders.where(status:"shipped").count
    @completed_orders = @orders.where(status:"completed").count
    @cancelled_orders = @orders.where(status: "cancelled").count
    @revenue = @orders.where.not(status: "cancelled").sum do |order|
      order.product.price * order.quantity
    end
  end

  def orders
      @store = current_user.stores.find(params[:store_id])
      @pending_orders = @store.orders.where(status:"pending").includes(:product).order(created_at: :desc)
      @shipped_orders = @store.orders.where(status:"shipped").includes(:product).order(created_at: :desc)
      @completed_orders = @store.orders.where(status:"completed").includes(:product).order(created_at: :desc)
      @cancelled_orders = @store.orders.where(status:"cancelled").includes(:product).order(created_at: :desc)
      
    
    
  end

  private

  def ensure_owner
    redirect_to root_path unless current_user.owner?
  end
end
