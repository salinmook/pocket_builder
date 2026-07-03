class CartItemsController < ApplicationController

    def create 
        @product = Product.find(params[:product_id])
        cart = Cart.find_or_create_by(store: current_store)
        item = cart.cart_items.find_by(product: @product)
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
        @cart_item = CartItem.find(params[:id])
        @cart_item.increment!(:quantity) 
        @product = @cart_item.product
        @cart = @cart_item.cart.reload

        render_cart_streams
    end

    def decrease
        @cart_item = CartItem.find(params[:id])
        @product = @cart_item.product
        @cart = @cart_item.cart.reload

        if @cart_item.quantity > 1
            @cart_item.decrement!(:quantity)
        else
           @cart_item.destroy
        end

        render_cart_streams
    end

    def destroy
        @cart_item = CartItem.find(params[:id])
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
            locals: { cart: @cart }
        )
       ]
    end
    

end
