class RemoveLatitudeLongitudeFromPictures < ActiveRecord::Migration[5.2]
  def change
    remove_column :pictures, :latitude
    remove_column :pictures, :longitude, :string
  end
end
