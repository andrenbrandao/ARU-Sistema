class AddDefaultToRepresentante < ActiveRecord::Migration
  def self.up
  	change_column :moradores, :representante, :boolean, :default => false, :null => false
  end

  def self.down
  	change_column :moradores, :representante, :boolean
  end
end
