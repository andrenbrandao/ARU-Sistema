class RemoveTermsFromRepublica < ActiveRecord::Migration
  def up
    remove_column :republicas, :terms
  end

  def down
    add_column :republicas, :terms, :boolean
  end
end
