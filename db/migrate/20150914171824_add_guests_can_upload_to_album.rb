class AddGuestsCanUploadToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :guests_can_upload, :boolean
  end
end
