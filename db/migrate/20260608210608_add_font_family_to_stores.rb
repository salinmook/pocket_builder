class AddFontFamilyToStores < ActiveRecord::Migration[8.1]
  def change
    add_column :stores, :font_family, :string
  end
end
