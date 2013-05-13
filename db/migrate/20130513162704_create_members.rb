class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :user_id
      t.integer :album_id
      t.boolean :can_administer
      t.boolean :can_addphotos

      t.timestamps
    end
  end
end
