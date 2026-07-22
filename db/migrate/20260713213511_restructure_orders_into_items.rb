class RestructureOrdersIntoItems < ActiveRecord::Migration[8.1]
  def up
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price
      t.timestamps
  end

  execute <<-SQL
  INSERT INTO order_items (order_id, product_id, quantity, price, created_at, updated_at)
  SELECT id, product_id, quantity, price, created_at, updated_at FROM orders
  SQL

  remove_column :orders, :product_id
  remove_column :orders, :quantity
  remove_column :orders, :price
end

  def down
    add_column :orders, :product_id,:bigint 
    add_column :orders, :quantity, :integer
    add_column :orders, :price, :decimal

    execute <<-SQL
      UPDATE orders SELECT
        product_id = order_items.product_id,
        quantity = order_items.quantity,
        price = order_items.price
      FROM order_items
      WHERE order_items.order_id = orders.id
    SQL

    drop_table :order_items
  end
end
