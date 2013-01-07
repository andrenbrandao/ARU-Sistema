class AddDetailsToMoradores < ActiveRecord::Migration
  def change
    add_column :moradores, :email, :string
    add_column :moradores, :celular, :string
    add_column :moradores, :representante, :boolean
  end
end
