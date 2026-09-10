class AddAboutFieldsToStores < ActiveRecord::Migration[8.1]
  def change
    add_column :stores, :about_description, :text
  end
end
