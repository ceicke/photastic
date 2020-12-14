class RemoveYoFromAlbums < ActiveRecord::Migration[5.2]
  def change
    remove_column :albums, :yo_api_key
    remove_column :albums, :yo_username
  end
end
