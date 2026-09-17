class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations do |t|
      t.references :store, null: false, foreign_key: true
      t.string :label
      t.text :address, null: false
      t.string :phone
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longtitude, precision: 10, scale: 6

      t.timestamps
    end
  end
end
