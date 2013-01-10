class AddUsernameToRepublica < ActiveRecord::Migration
  def change
    add_column :republicas, :username, :string
  end
end
