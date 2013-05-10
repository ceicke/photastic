class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :album_id
      t.integer :user_id
      t.string :description

      t.timestamps
    end
    add_index :pictures, :album_id
  end
end
