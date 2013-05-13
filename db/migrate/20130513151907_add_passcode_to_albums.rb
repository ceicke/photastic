class AddPasscodeToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :passcode, :string
  end
end
