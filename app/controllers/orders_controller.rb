class OrdersController < ApplicationController
    before_action :authenticate_user!

    def index
        @orders = current_store.orders.includes(order_items: :product).order(created_at: :desc)
    end

    def show
        @order = Order.includes(order_items: :product).find(params[:id])
    end

    def create 
        product = Product.find(params[:product_id])
        order = Order.create!(
            store: product.store,
            user: current_user,
            status: "pending"
        )

        order.order_items.create!(
            product: product,
            quantity: 1,
            price: product.price
        )

        product.update!(
            stock: product.stock - 1
        )

        redirect_to store_path(product.store), notice: "Order created!"
    end

    def checkout
        @cart = Cart.find_or_create_by(store: current_store)
        
        if @cart.cart_items.empty?
            redirect_to cart_path(@cart), alert: "Your cart is empty" and return
        end

        order = Order.create!(
                store: current_store,
                user: current_user,
                status: "pending"
                )
        @cart.cart_items.each do |item|
            order.order_items.create!(
                product: item.product,
                quantity: item.quantity,
                price: item.product.price
            )
            product = item.product
            product.update!(
                stock: product.stock - item.quantity
            )
        end
        @cart.cart_items.destroy_all
        redirect_to order_success_path(store_id: current_store.id), notice: "Order created successfully!"
                
    end
           

    def success
        @store = current_store
    end

    def cancel 
        @order = Order.find(params[:id])
        @order.update(status:"cancelled")
        redirect_to orders_path, notice: "Order cancelled"
    end

    def ship
        @order = Order.find(params[:id])
        @order.update(status:"shipped")
        redirect_back fallback_location: orders_path, notice: "Order shipped"
    end

    def complete
        @order = Order.find(params[:id])
        @order.update(status:"completed")
        redirect_back fallback_location: orders_path, notice: "Order completed"
    end
        

end
