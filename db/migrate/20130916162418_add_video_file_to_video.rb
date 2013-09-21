class AddVideoFileToVideo < ActiveRecord::Migration
  def self.up
    add_attachment :videos, :video_file
  end

  def self.down
    remove_attachment :videos, :video_file
  end
end
