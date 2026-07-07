class DashboardController < ApplicationController 
  layout "dashboard"
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

  def products
    @store = current_user.stores.find_by(id:params[:store_id])

    redirect_to stores_path, alert: "Store not found" and return unless @store

    @products = @store.products
    if params[:query].present?
      @products = @products.where("title ILIKE ?", "%#{params[:query]}%")
    end

    @low_stock_products = @products.where("stock > 0 AND stock <= 5")
    @out_of_stock_products = @products.where(stock: 0)
  end


  def customers
    @store = current_user.stores.find(params[:store_id])
    @orders = @store.orders.includes(:user).order(created_at: :desc)
    @customers = @orders.map(&:user).uniq
  end

  def analytics
    @store = current_user.stores.find(params[:store_id])
    @monthly_revenue = @store.orders
    .where.not(status: "cancelled")
    .group_by { |order| order.created_at.strftime("%b%Y") }
    .transform_values do |orders|
      orders.sum { |order| order.product.price * order.quantity}
    end
  end

  def finance
    @store = current_user.stores.find(params[:store_id])
    @orders = @store.orders.where.not(status: "Cancelled")
    @revenue = @orders.sum do |order| order.product.price * order.quantity
    end
    @shipping_cost = 0
    @promotion_cost = 0
    @refund = 0
    @profit = @revenue - @shipping_cost - @promotion_cost - @refund
  end


  private

  def ensure_owner
    redirect_to root_path unless current_user.owner?
  end
end
