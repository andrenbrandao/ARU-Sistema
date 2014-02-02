class CreateServicos < ActiveRecord::Migration
  def change
    create_table :servicos do |t|
      t.string :nome
      t.string :endereco
      t.string :tel1
      t.string :tel2
      t.string :email
      t.string :site
      t.text :descricao
      t.float :preco
      t.integer :avaliacao
      t.integer :republica_id, :null => false

      t.timestamps
    end
    add_index :servicos, :republica_id
  end
end
