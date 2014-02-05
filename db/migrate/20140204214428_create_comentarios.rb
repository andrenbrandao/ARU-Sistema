class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.text :texto
      t.integer :republica_id
      t.integer :servico_id

      t.timestamps
    end
    add_index :comentarios, :republica_id
    add_index :comentarios, :servico_id
  end
end
