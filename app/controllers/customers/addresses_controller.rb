class Customers::AddressesController < ApplicationController
    before_action :require_customer_login!
    before_action :set_store
    before_action :set_address, only: [:edit, :update, :destroy, :select]

    def index
        @addresses = current_customer.addresses.order(is_default: :desc, created_at: :desc)
        @checkout_mode = params[:checkout].present?
    end

    def new
        @address = current_customer.addresses.new
        @checkout_mode = params[:checout].present?
    end

    def create
        @address = current_customer.addresses.new(address_params)
        if @address.save
            if params[:checkout].present?
                session[:checkout_address_id] = @address.id
            redirect_to new_checkout_path, notice: "Address added"
        else
            redirect_to store_addresses_path(@store), notice: "Address added"
        end
    else
        render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @address.update(address_params)
            redirect_to store_addresses_path(@store), notice: "Address updated"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @address.destroy
        redirect_to store_addresses_path(@store), notice: "Address removed"
    end

    def select
        session[:checkout_address_id] = @address.id
        redirect_to new_checkout_path, notice: "Delivery address updated"
    end
    
    private

    def set_store
        @store = Store.find(params[:store_id])
    end

    def set_address
        @address = current_customer.addresses.find(params[:id])
    end

    def address_params
        params.require(:address).permit(:label, :name, :phone, :address_line, :is_default)
    end
    
end
