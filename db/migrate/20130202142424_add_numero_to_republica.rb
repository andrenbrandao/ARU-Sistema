class AddNumeroToRepublica < ActiveRecord::Migration
  def change
    add_column :republicas, :numero, :integer
  end
end
