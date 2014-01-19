class TransferAtributoCampeaInterrepsToOwnTable < ActiveRecord::Migration
	def up
		remove_column :republicas, :campea_interreps

		create_table :interreps_vencidos do |t|
			t.integer :ano, :null => false
			t.integer :republica_id, :null => false

			t.timestamps
		end
		add_index :interreps_vencidos, :republica_id
	end

	def down
		drop_table :interreps_vencidos
		add_column :republicas, :campea_interreps, :string
	end
end
