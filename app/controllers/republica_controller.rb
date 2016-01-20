class RepublicaController < ApplicationController
	# load_and_authorize_resource
	# helper_method :sort_column, :sort_direction
	before_filter :check_approved_republica

	private

	def check_approved_republica
		if republica_signed_in? && !current_republica.approved?
			redirect_to root_path, :alert => I18n.t('unauthorized.not_approved')
		end
	end
end