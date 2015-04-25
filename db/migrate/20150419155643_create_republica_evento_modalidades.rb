class CreateRepublicaEventoModalidades < ActiveRecord::Migration
  def change
    create_table :republica_evento_modalidades do |t|
      t.references :republica
      t.references :evento_modalidade

      t.timestamps
    end
    add_index :republica_evento_modalidades, :republica_id
    add_index :republica_evento_modalidades, :evento_modalidade_id
  end
end
