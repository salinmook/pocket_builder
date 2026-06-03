class CreateStores < ActiveRecord::Migration[8.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.text :description
      t.string :theme
      t.string :address
      t.string :phone
      t.string :instagram
      t.string :facebook
      t.boolean :active, default: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
