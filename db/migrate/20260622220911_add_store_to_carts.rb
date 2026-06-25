class AddStoreToCarts < ActiveRecord::Migration[8.1]
  def change
    add_reference :carts, :store, foreign_key: true
  end
end
