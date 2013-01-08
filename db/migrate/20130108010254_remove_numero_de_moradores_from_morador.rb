class RemoveNumeroDeMoradoresFromMorador < ActiveRecord::Migration
  def up
    remove_column :moradores, :numero_de_moradores
  end

  def down
    add_column :moradores, :numero_de_moradores, :integer
  end
end
