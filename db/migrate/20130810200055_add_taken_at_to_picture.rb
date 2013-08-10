class AddTakenAtToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :taken_at, :datetime
  end
end
