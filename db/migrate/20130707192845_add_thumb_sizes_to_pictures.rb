class AddThumbSizesToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :image_width_large, :integer
    add_column :pictures, :image_height_large, :integer
    add_column :pictures, :image_width_medium, :integer
    add_column :pictures, :image_height_medium, :integer
  end
end
