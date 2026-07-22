class Dashboard::CouponsController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_store
  before_action :set_coupon, only: [:edit, :update, :destroy]

  def index 
    @coupons = @store.coupons.order(created_at: :desc)
  end

  def new
    @coupon = @store.coupons.new
  end

  def create
    @coupon = @store.coupons.new(coupon_params)
    if @coupon.save
      redirect_to store_coupons_path(@store), notice: "Coupon created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @coupon.update(coupon_params)
      redirect_to store_coupons_path(@store), notice: "Coupon updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @coupon.destroy
    redirect_to store_coupons_path(@store), notice: "Coupon deleted"
  end

  private

  def set_store
    @store = current_user.stores.find(params[:store_id])
end

  def set_coupon
  @coupon = @store.coupons.find(params[:id])
end

  def coupon_params
  params.require(:coupon).permit(
    :code, :discount_type, :discount_value,
    :minimum_order_amount, :starts_at, :ends_at,
    :usage_limit, :active
  )
  end

end
