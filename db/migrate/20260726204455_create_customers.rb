class CreateCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :customers do |t|
      t.references :store, null: false, foreign_key: true
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :name

      t.timestamps
    end
    add_index :customers, [:store_id, :email], unique: true
    add_index :customers, :reset_password_token, unique: true
  end
end
