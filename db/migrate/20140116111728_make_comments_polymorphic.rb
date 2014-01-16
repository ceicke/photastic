class MakeCommentsPolymorphic < ActiveRecord::Migration
  def up
    change_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
    end

    Comment.reset_column_information

    Comment.all.each do |c|
      c.update_attributes(commentable_id: c.picture_id, commentable_type: 'Picture')
    end

    change_table :comments do |t|
      t.remove :picture_id
    end
  end

  def down
    change_table :comments do |t|
      t.integer :picture_id
    end

    Comment.reset_column_information

    Comment.all.each do |c|
      c.update_attribute(:picture_id, c.commentable_id)
    end

    change_table :comments do |t|
      t.remove :commentable_type, :commentable_id
    end
  end
end