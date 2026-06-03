class StoresController < ApplicationController
    before_action :authenticate_user!

    def index
        @stores = current_user.stores
    end

    def new
        @store = Store.new
    end

    def create
        @store = Store.new(store_params)
        @store.user = current_user
        
        if @store.save
            redirect_to @store
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @store = @store = current_user.stores.find(params[:id])
    end

    def update
        @store = current_user.stores.find(params[:id])
        if @store.update(store_params)
            redirect_to @store
        else 
            render :edit, status: :unprocessable_entity
        end
    end


    def show
        @store = current_user.stores.find(params[:id])
    end

    def destroy 
        @store = current_user.stores.find(params[:id])
        @store.destroy
        redirect_to stores_path
    end

    private
    def store_params
        params.require(:store).permit(
            :name,
            :description,
            :theme,
            :address,
            :phone,
            :instagram,
            :facebook
        )
    end
end
