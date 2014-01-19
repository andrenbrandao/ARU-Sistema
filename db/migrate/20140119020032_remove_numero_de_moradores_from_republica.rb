class RemoveNumeroDeMoradoresFromRepublica < ActiveRecord::Migration
	def up
		remove_column :republicas, :numero_de_moradores
	end

	def down
		add_column :republicas, :numero_de_moradores, :integer
	end
end
