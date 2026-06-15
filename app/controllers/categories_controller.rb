class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_store
    before_action :set_category, only: [:edit, :update, :destroy]

    def new
        @category = Category.new
    end

    def create
        @category = @store.categories.build(category_params)
        if @category.save
            redirect_to store_path(@store)
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @category.update(category_params)
            redirect_to store_path(@store)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @category.destroy
        redirect_to store_path(@store), status: :see_other
    end

    private

    def set_store
        @store = current_user.stores.find(params[:store_id])
    end

    def set_category
        @category = @store.categories.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end
end
