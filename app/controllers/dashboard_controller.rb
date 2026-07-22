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
    @revenue = OrderItem.joins(:order)
                        .where(orders: { store_id: @store.id })
                        .where.not(orders: { status: "cancelled" })
                        .sum("order_items.quantity * order_items.price")

  end

  def orders
      @store = current_user.stores.find(params[:store_id])
      @pending_orders = @store.orders.where(status:"pending").includes(order_items: :product).order(created_at: :desc)
      @shipped_orders = @store.orders.where(status:"shipped").includes(order_items: :product).order(created_at: :desc)
      @completed_orders = @store.orders.where(status:"completed").includes(order_items: :product).order(created_at: :desc)
      @cancelled_orders = @store.orders.where(status:"cancelled").includes(order_items: :product).order(created_at: :desc)
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
    @period = params[:period].presence_in(%w[day month year]) || "month"
    items = OrderItem.joins(:order)
                     .where(orders: { store_id: @store.id })
                     .where.not(orders: { status: "cancelled" })
    
    @monthly_revenue = case @period
    when "day"
      items.where(orders: { created_at: Time.current.beginning_of_month..Time.current.end_of_month })
           .group_by_day("orders.created_at", format: "%d %b")
           .sum("order_items.quantity * order_items.price")
    when "year"
      items.group_by_year("orders.created_at", format: "%Y")
           .sum("order_items.quantity * order_items.price")
    else
      items.group_by_month("orders.created_at", format: "%b %Y")
      .sum("order_items.quantity * order_items.price")
    end
    
  end

  def finance
    @store = current_user.stores.find(params[:store_id])
    @orders = @store.orders.where.not(status: "cancelled")
    items = OrderItem.joins(:order)
                     .where(orders: { store_id: @store.id })
                     .where.not(orders: { status: "cancelled" })

    @revenue = items.sum("order_items.quantity * order_items.price")
    @shipping_cost = 0
    @promotion_cost = 0
    @refund = 0
    @cost = items.joins(:product).sum("order_items.quantity * products.cost")
    @profit = @revenue - @shipping_cost - @promotion_cost - @refund - @cost
    
  end
    


  private

  def ensure_owner
    redirect_to root_path unless current_user.owner?
  end
end
