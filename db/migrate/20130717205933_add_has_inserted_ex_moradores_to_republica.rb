class AddHasInsertedExMoradoresToRepublica < ActiveRecord::Migration
  def change
    add_column :republicas, :has_inserted_ex_moradores, :boolean, :default => false, :null => false
  end
end
