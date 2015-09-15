class AddGuestUserToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :guest_user, :string
  end
end
