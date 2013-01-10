class RemoveAuthenticationFromRepublica < ActiveRecord::Migration
  def up
    remove_column :republicas, :username
    remove_column :republicas, :password_digest
  end

  def down
    add_column :republicas, :password_digest, :string
    add_column :republicas, :username, :string
  end
end
