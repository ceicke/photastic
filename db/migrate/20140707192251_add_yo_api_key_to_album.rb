class AddYoApiKeyToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :yo_api_key, :string
  end
end
