class AddNumeroDeMoradoresToRepublica < ActiveRecord::Migration
  def change
    add_column :republicas, :numero_de_moradores, :integer
  end
end
