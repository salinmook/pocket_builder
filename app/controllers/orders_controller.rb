class OrdersController < ApplicationController

    def index
        @orders = current_store.orders.order(created_at: :desc)
    end

    def show
        @order = Order.find(params[:id])
    end

    def create 
        product = Product.find(params[:product_id])
        Order.create!(
            product: product,
            store: product.store,
            quantity: 1
        )

        product.update!(
            stock: product.stock - 1
        )

        redirect_to store_path(product.store), notice: "Order created!"
    end

    def checkout
        @cart = Cart.find_or_create_by(store: current_store)
        @cart.cart_items.each do |item|

            Order.create!(
                product: item.product,
                store: item.product.store,
                quantity: item.quantity,
                status: "pending"
                )
                product = item.product
                product.stock -= item.quantity
                product.save
        end
            
           @cart.cart_items.destroy_all
        redirect_to order_success_path(store_id: current_store.id), notice: "order created sucessfully!"
    end

    def success
        @store = current_store
    end

    def cancel 
        @order = Order.find(params[:id])
        @order.update(status:"cancelled")
        redirect_to orders_path, notice: "Order cancelled"
    end

end
