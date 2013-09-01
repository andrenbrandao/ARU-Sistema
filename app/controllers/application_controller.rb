class ApplicationController < ActionController::Base
	protect_from_forgery

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_path, :alert => exception.message
	end


	def current_ability
		@current_ability ||= current_admin ? Ability.new(current_admin) : Ability.new(current_republica)
	end

	layout :determine_layout

	private
	def determine_layout
		if admin_signed_in?
			"admin"
		else
			"application"
		end
	end

end
