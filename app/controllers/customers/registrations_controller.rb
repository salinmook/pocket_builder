class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :set_store

  def new
    @customer = @store.customers.new
  end

  def create 
    guest_cart_id_before_signup = session[:guest_cart_id]
    @customer = @store.customers.new(customer_params)
    if @customer.save
      sign_in(:customer,@customer)
      session[:guest_cart_id] = guest_cart_id_before_signup
      redirect_to store_path(@store), notice: "Account created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def customer_params
    params.require(:customer).permit(:email, :password, :password_confirmation, :name)
  end
end
