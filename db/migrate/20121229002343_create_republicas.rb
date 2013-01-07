class CreateRepublicas < ActiveRecord::Migration
  def change
    create_table :republicas do |t|
      t.string :nome
      t.string :tipo
      t.integer :ano_de_fundacao
      t.text :descricao
      t.string :endereco
      t.string :telefone
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end
