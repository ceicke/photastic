class AddSubdomainToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :subdomain, :string
  end
end
