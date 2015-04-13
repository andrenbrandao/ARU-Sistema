class CreateEventoMoradores < ActiveRecord::Migration
  def change
    create_table :evento_moradores do |t|
      t.references :evento
      t.references :morador

      t.timestamps
    end
    add_index :evento_moradores, :evento_id
    add_index :evento_moradores, :morador_id
  end
end
