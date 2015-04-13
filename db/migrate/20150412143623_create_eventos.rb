class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nome, null: false
      t.integer :ano, null: false

      t.timestamps
    end
  end
end
