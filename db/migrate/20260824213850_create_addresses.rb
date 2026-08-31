class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :label
      t.string :name, null: false
      t.string :phone, null: false
      t.text :address_line, null: false
      t.boolean :is_default, default: false, null: false

      t.timestamps
    end
  end
end
