class OrdersController < ApplicationController
    before_action :require_customer_login!, only: [:index, :show, :create, :checkout, :cancel]
    before_action :authenticate_user!, only:[:ship, :complete]

    def index
        @orders = current_customer.orders.includes(order_items: :product).order(created_at: :desc)
    end

    def show
        @order = current_customer.orders.includes(order_items: :product).find(params[:id])
    end

    def create 
        product = Product.find(params[:product_id])
        order = Order.create!(
            store: product.store,
            customer: current_customer,
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

    def new_checkout
        @cart = current_cart
        if @cart.cart_items.empty?
            redirect_to cart_path(@cart), alert: "Your cart is empty" and return
        end
    end

    def checkout
        @cart = current_cart
        
        if @cart.cart_items.empty?
            redirect_to cart_path(@cart), alert: "Your cart is empty" 
            return
        end

        out_of_stock_item = @cart.cart_items.find{ |item| item.quantity > item.product.stock }
        if out_of_stock_item
            redirect_to cart_path(@cart), alert: "#{out_of_stock_item.product.title} only has #{out_of_stock_item.product.stock} left in stock"
            return
        end
        
        if shipping_params[:shipping_name].blank? || shipping_params[:shipping_phone].blank? || shipping_params[:shipping_address].blank?
            @cart = current_cart
            flash.now[:alert] = "Please fill in all shipping details"
            render :new_checkout, status: :unprocessable_entity and return
        end

        coupon = @cart.coupon
        discount = @cart.discount_amount

        order = Order.create!(
                store: current_store,
                customer: current_customer,
                status: "pending",
                coupon: coupon,
                discount_amount: discount,
                shipping_name: shipping_params[:shipping_name],
                shipping_phone: shipping_params[:shipping_phone],
                shipping_address: shipping_params[:shipping_address]
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

        coupon&.increment!(:usage_count)
        @cart.cart_items.destroy_all
        @cart.update(coupon: nil)
        redirect_to order_success_path(store_id: current_store.id), notice: "Order created successfully!"
                
    end
           

    def success
        @store = current_store
    end

    def cancel 
        @order = current_customer.orders.find(params[:id])
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

    private
    def shipping_params
        params.permit(:shipping_name, :shipping_phone, :shipping_address)
    end
        

end
