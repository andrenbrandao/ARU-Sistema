class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :servico_id
      t.integer :categoria_id

      t.timestamps
    end
    add_index :categorizations, :servico_id
    add_index :categorizations, :categoria_id
  end
end
