class Customers::SessionsController < Devise::SessionsController
  before_action :set_store
  def new
    super
  end

  def create
    guest_cart_id_before_login = session[:guest_cart_id]
    customer = @store.customers.find_by(email: params[:customer][:email])
    if customer&.valid_password?(params[:customer][:password])
      sign_in(:customer, customer)
      session[:guest_cart_id] = guest_cart_id_before_login
      redirect_to store_path(@store), notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out(:customer)
    redirect_to store_path(@store), notice: "Logged out"
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end
end
