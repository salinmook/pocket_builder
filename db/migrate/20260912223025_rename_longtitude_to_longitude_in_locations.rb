class RenameLongtitudeToLongitudeInLocations < ActiveRecord::Migration[8.1]
  def change
    rename_column :locations, :longtitude, :longitude
  end
end
