class CartItemsController < ApplicationController

    def create 
        @product = Product.find(params[:product_id])
        cart = Cart.find_or_create_by(store:current_store)
        item = cart.cart_items.find_by(product:@product)
        if item
                item.quantity += 1
                item.save
            else
                cart.cart_items.create(
                    product: @product,
                    quantity: 1
                )
            end
            redirect_back fallback_location: root_path
        
    end

    def increase
        item = CartItem.find(params[:id])
        item.increment!(:quantity)
        redirect_to cart_path(1)
    end

    def decrease
        item = CartItem.find(params[:id])
        if item.quantity > 1
            item.decrement!(:quantity)
        else
            item.destroy
        end
        redirect_to cart_path(1)
    end

    def destroy
        item = CartItem.find(params[:id])
        item.destroy
        redirect_to cart_path(1)
    end
    

end
