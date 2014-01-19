class RemoveCropAndSizesColumnsFromSchema < ActiveRecord::Migration
	def up
		remove_column :republicas, :crop_x
		remove_column :republicas, :crop_y
		remove_column :republicas, :crop_w
		remove_column :republicas, :crop_h
		remove_column :republicas, :original_height
		remove_column :republicas, :original_width
	end
end
