class AddTermsToRepublica < ActiveRecord::Migration
  def change
    add_column :republicas, :terms, :boolean
  end
end
