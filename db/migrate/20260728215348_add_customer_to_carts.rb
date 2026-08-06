class AddCustomerToCarts < ActiveRecord::Migration[8.1]
  def change
    add_reference :carts, :customer, foreign_key: true, null: true
  end
end
