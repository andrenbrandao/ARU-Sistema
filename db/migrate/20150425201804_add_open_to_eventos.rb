class AddOpenToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :open, :boolean, :default => false, :null => false
  end
end
