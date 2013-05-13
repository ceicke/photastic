class AddThumbImageToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :picture_id, :integer
  end
end
