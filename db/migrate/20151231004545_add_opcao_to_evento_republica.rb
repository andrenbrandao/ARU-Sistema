class AddOpcaoToEventoRepublica < ActiveRecord::Migration
  def change
    add_column :evento_republicas, :opcao, :integer
  end
end
