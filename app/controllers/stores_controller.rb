class StoresController < ApplicationController
    before_action :authenticate_user!, except: [:show, :about, :faq, :contact]

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
        @store = Store.find(params[:id])
        session[:store_id] = @store.id
        if params[:query].present?
            @products = @store.products.where("title ILIKE ?",
            "%#{params[:query]}%")
        else
            @products = @store.products
        end
    end

    def destroy 
        @store = current_user.stores.find(params[:id])
        @store.destroy
        redirect_to stores_path
    end

    def remove_logo
        @store = current_user.stores.find(params[:id])
        @store.logo.purge if @store.logo.attached?
        redirect_to edit_store_path(@store), notice: "Logo removed"
    end

    def remove_banner
        @store = current_user.stores.find(params[:id])
        @store.banner.purge if @store.banner.attached?
        redirect_to edit_store_path(@store), notice: "Banner removed"
    end

    def about
        @store = Store.find(params[:id])
    end

    def faq
        @store = Store.find(params[:id])
    end

    def contact
        @store = Store.find(params[:id])
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
            :facebook,
            :logo,
            :banner,
            :primary_color,
            :active,
            :font_family
        )
    end
end
