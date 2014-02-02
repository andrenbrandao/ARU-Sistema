class CreateCategorias < ActiveRecord::Migration
	def change
		create_table :categorias do |t|
			t.string :nome
			t.integer :republica_id, :null => false

			t.timestamps
		end
		add_index :categorias, :republica_id
	end
end
