class RemoveHasInsertedExMoradoresFromRepublica < ActiveRecord::Migration
  def change
  	remove_column :republicas, :has_inserted_ex_moradores
  end
end
