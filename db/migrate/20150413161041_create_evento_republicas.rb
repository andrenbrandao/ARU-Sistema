class CreateEventoRepublicas < ActiveRecord::Migration
  def change
    create_table :evento_republicas do |t|
      t.references :evento
      t.references :republica
      t.string :agregado

      t.timestamps
    end
    add_index :evento_republicas, :evento_id
    add_index :evento_republicas, :republica_id
  end
end
