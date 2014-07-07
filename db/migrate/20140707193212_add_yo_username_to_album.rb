class AddYoUsernameToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :yo_username, :string
  end
end
