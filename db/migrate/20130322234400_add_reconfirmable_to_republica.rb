class AddReconfirmableToRepublica < ActiveRecord::Migration
	def up
		change_table(:republicas) do |t|
       t.string   :unconfirmed_email # Only if using reconfirmable
  end
end

def down
	remove_column :republicas, :unconfirmed_email
end
end
