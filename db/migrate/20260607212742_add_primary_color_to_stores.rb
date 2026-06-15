class AddPrimaryColorToStores < ActiveRecord::Migration[8.1]
  def change
    add_column :stores, :primary_color, :string
  end
end
