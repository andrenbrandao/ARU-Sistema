class AddApprovedToRepublica < ActiveRecord::Migration
  def self.up
    add_column :republicas, :approved, :boolean, :default => false, :null => false
    add_index  :republicas, :approved
  end
  def self.down
    remove_index  :republicas, :approved
    remove_column :republicas, :approved
  end
end
