class AdminController < ApplicationController
	# load_and_authorize_resource
	# helper_method :sort_column, :sort_direction
	before_filter :authenticate_admin!
	skip_before_filter :authenticate_republica!
	layout 'admin'
end