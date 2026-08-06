class CartItemsController < ApplicationController
    

    def create 
        @product = Product.find(params[:product_id])
        cart = current_cart
        item = cart.cart_items.find_by(product: @product)
        current_qty = item ? item.quantity : 0
        if current_qty + 1 > @product.stock
            @cart = cart.reload
            render turbo_stream: turbo_stream.replace(
                "cart",
                partial: "carts/cart",
                locals: { cart: @cart, cart_error: "Not enough stock for #{@product.title}" }
            )
            return
        end

        if item
            item.increment!(:quantity)
        else
            item = cart.cart_items.create(
            product: @product,
            quantity: 1
            )
        end
        @cart = cart.reload
        render_cart_streams
    end

    def increase
        @cart_item = current_cart.cart_items.find(params[:id])
        @product = @cart_item.product
        @cart = current_cart
        
        if @cart_item.quantity + 1 > @product.stock
            render turbo_stream: turbo_stream.replace(
                "cart",
                partial: "carts/cart",
                locals: { cart: @cart, cart_error: "Not enough stock for #{@product.title}" }
            )
            return
        end
        @cart_item.increment!(:quantity) 
        @cart = @cart.reload
        render_cart_streams
    end

    def decrease
        @cart_item = current_cart.cart_items.find(params[:id])
        @product = @cart_item.product
        @cart = current_cart

        if @cart_item.quantity > 1
            @cart_item.decrement!(:quantity)
        else
           @cart_item.destroy
        end
        @cart = @cart.reload
        render_cart_streams
    end

    def destroy
        @cart_item = current_cart.cart_items.find(params[:id])
        @product = @cart_item.product
        @cart = @cart_item.cart.reload
        @cart_item.destroy
        
        render_cart_streams
    end

    private

    def render_cart_streams
        render turbo_stream: [
            turbo_stream.replace(
            "product_#{@product.id}",
            partial: "products/cart_controls",
            locals: { product: @product, cart: @cart }
        ),
        turbo_stream.replace(
            "cart",
            partial: "carts/cart",
            locals: { cart: @cart, cart_error: nil }
        )
       ]
    end
    

end
