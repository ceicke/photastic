class AddEncodedToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :encoded, :boolean, :default => false 
  end
end
