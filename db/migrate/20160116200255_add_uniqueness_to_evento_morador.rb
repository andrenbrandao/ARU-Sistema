class AddUniquenessToEventoMorador < ActiveRecord::Migration
  def change
  	add_index :evento_moradores, [:evento_id, :morador_id], :unique => true
  end
end
