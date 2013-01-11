class AddLogotipoToRepublica < ActiveRecord::Migration
  def change
    add_column :republicas, :logotipo, :string
  end
end
