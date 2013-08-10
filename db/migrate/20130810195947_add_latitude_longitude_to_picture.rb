class AddLatitudeLongitudeToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :latitude, :string
    add_column :pictures, :longitude, :string
  end
end
