class AddTypeOfPlayerToEventoMoradores < ActiveRecord::Migration
  def change
    add_column :evento_moradores, :type_of_player, :boolean, :default => false, :null => false
  end
end
