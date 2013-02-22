class AddDataDeSaidaToMorador < ActiveRecord::Migration
  def change
    add_column :moradores, :data_de_saida, :datetime
  end
end
