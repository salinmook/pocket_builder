class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :set_store

  def new
    @customer = @store.customers.new
  end

  def create 
    guest_cart_id_before_signup = session[:guest_cart_id]
    @customer = @store.customers.new(customer_params)
    if @customer.save
      sign_in(:customer, @customer)
      session[:guest_cart_id] = guest_cart_id_before_signup
      redirect_to store_path(@store), notice: "Account created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @customer = current_customer
  end

  def update 
    @customer = current_customer
    if params[:customer][:password].blank?
      update_params_without_password = update_params.except(:password, :password_confirmation, :current_password)
      success = @customer.update(update_params_without_password)
    else
      success = @customer.update_with_password(update_params)
    end 

    if success
      bypass_sign_in(@customer)
      redirect_to store_path(@store), notice: "Profile updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def customer_params
    params.require(:customer).permit(:email, :password, :password_confirmation, :name)
  end

  def update_params
    params.require(:customer).permit(:name, :email, :avatar, :password, :password_confirmation, :current_password)
  end
end
