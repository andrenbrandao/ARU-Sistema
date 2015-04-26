class AddMaxNumberAgregadosAndExmoradoresToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :max1_ag, :integer, default: 0
    add_column :eventos, :max1_ex, :integer, default: 0
    add_column :eventos, :max2_ag, :integer, default: 0
    add_column :eventos, :max2_ex, :integer, default: 0
  end
end
