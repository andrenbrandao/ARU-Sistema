class CreateVagasForRepublicas < ActiveRecord::Migration
	def change
		create_table :vagas do |t|
			t.datetime :abertas, :default => nil
			t.integer :republica_id, :null => false, :unique => true

			t.timestamps
		end
		add_index :vagas, :republica_id
	end
end
