class AddStoreToOrders < ActiveRecord::Migration[8.1]
  def change
    add_reference :orders, :store, foreign_key: true
  end
end
