class RenameMembersToAlbumMembers < ActiveRecord::Migration
  def change
    rename_table :members, :album_members
  end
end
