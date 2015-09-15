class AddGuestUserToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :guest_user, :string
  end
end
