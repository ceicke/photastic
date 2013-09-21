class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :album_id
      t.integer :user_id
      t.string :description

      t.timestamps
    end
    add_index :videos, :album_id
  end
end
