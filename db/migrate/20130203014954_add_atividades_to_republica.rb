class AddAtividadesToRepublica < ActiveRecord::Migration
  def change
    add_column :republicas, :campea_interreps, :string
    add_column :republicas, :presente_reunioes, :boolean
  end
end
