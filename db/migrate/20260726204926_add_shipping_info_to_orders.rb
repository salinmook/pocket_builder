class AddShippingInfoToOrders < ActiveRecord::Migration[8.1]
  def change
    add_reference :orders, :customer, foreign_key: true, null: true
    add_column :orders, :shipping_name, :string
    add_column :orders, :shipping_phone, :string
    add_column :orders, :shipping_address, :text
  end
end
