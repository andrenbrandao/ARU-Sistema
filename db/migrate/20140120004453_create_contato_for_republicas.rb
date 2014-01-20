class CreateContatoForRepublicas < ActiveRecord::Migration
	def change
		create_table :contatos do |t|
			t.string :email, :default => nil
			t.string :nome1, :default => nil
			t.string :tel1, :default => nil
			t.string :nome2, :default => nil
			t.string :tel2, :default => nil
			t.integer :republica_id, :null => false, :unique => true

			t.timestamps
		end
		add_index :contatos, :republica_id
	end
end
