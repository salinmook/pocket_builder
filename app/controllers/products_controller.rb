class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_store

    def new
        
        @product = Product.new
    end

    def create
        
        @product = Product.new(product_params)
        @product.store = @store
        if @product.save
            redirect_to store_path(@store)
        else 
            render :new, status: :unprocessable_entity
        end
    end

    def edit 
        
        @product = @store.products.find(params[:id])
    end

    def show 
        @product = @store.products.find(params[:id])
    end

    def  update 
        
        @product = @store.products.find(params[:id])
        
        if @product.update(product_params.except(:images))
            if params[:product][:images].present?
                @product.images.attach(params[:product][:images])
            end
            redirect_to store_path(@store)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy 
        
        @product = @store.products.find(params[:id])
        @product.destroy
        redirect_to store_path(@store), status: :see_other
    end

    def remove_image
        @product = @store.products.find(params[:id])
        image = @product.images.attachments.find(params[:image_id])
        image.purge
        redirect_to edit_store_product_path(@store, @product), notice: "Image removed"
    end

    private

    def product_params
        params.require(:product).permit(
            :title,
            :description,
            :price,
            :stock,
            :category_id,
            images: []
        )
    end

    def set_store
        @store = current_user.stores.find(params[:store_id])
    end
end
