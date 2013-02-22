class AdminController < ApplicationController
	def dashboard
		@republica = Republica.where(approved: true)
		@republica.each do |republica|
			@exmoradores ||= republica.moradores.where(exmorador: true)
		end

		respond_to do |format|
	      format.html # index.html.erb
	  end
	end
end