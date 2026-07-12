class AddPriceToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :price, :decimal
  end
end
