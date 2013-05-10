class AddPictureFileToPicture < ActiveRecord::Migration
  def self.up
    add_attachment :pictures, :picture_file
  end

  def self.down
    remove_attachment :pictures, :picture_file
  end
end
