class CreateMoradores < ActiveRecord::Migration
  def change
    create_table :moradores do |t|
      t.string :nome
      t.string :sobrenome
      t.string :curso
      t.integer :ano_de_ingresso
      t.string :ra
      t.string :universidade
      t.integer :republica_id

      t.timestamps
    end
  end
end
