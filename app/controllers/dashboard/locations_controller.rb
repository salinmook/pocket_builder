class Dashboard::LocationsController < ApplicationController
    layout "dashboard"
    before_action :authenticate_user!
    before_action :set_store
    before_action :set_location, only: [:edit, :update, :destroy]

    def index
        @locations = @store.locations.order(created_at: :asc)
    end

    def new
        @location = @store.locations.new
    end

    def create
        @location = @store.locations.new(location_params)
        if @location.save 
            redirect_to store_locations_path(@store), notice: "Location added"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @location.update(location_params)
            redirect_to store_locations_path(@store), notice: "Location updated"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @location.destroy
        redirect_to store_locations_path(@store), notice: "Location removed"
    end

    private

    def set_store
        @store = current_user.stores.find(params[:store_id])
    end

    def set_location 
        @location = @store.locations.find(params[:id])
    end

    def location_params
        params.require(:location).permit(:label, :address, :phone, :latitude, :longitude)
    end

end
