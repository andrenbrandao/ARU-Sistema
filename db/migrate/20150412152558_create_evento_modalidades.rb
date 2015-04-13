class CreateEventoModalidades < ActiveRecord::Migration
  def change
    create_table :evento_modalidades do |t|
      t.references :evento
      t.references :modalidade

      t.timestamps
    end
    add_index :evento_modalidades, :evento_id
    add_index :evento_modalidades, :modalidade_id
  end
end
