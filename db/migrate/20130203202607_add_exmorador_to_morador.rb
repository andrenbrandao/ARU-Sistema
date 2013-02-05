class AddExmoradorToMorador < ActiveRecord::Migration
  def change
    add_column :moradores, :exmorador, :boolean, :default => false, :null => false
  end
end
