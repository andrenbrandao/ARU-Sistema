class CreateSocialInformationForRepublicas < ActiveRecord::Migration
	def change
		create_table :social_informations do |t|
			t.string :website, :default => nil
			t.string :facebook, :default => nil
			t.string :googleplus, :default => nil
			t.string :youtube, :default => nil
			t.string :twitter, :default => nil
			t.integer :republica_id, :null => false, :unique => true

			t.timestamps
		end
		add_index :social_informations, :republica_id
	end
end
