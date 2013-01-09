class AddApelidoToMoradores < ActiveRecord::Migration
  def change
    add_column :moradores, :apelido, :string
  end
end
