module RepublicasHelper

	def resource_name
		:republica
	end

	def resource
		@resource ||= Republica.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:republica]
	end

end
