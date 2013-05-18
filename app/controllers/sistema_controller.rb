class SistemaController < ApplicationController
	def index
		@index_header = true;
	end

	def terms
		respond_to do |format|
      format.html # new.html.erb
      format.json 
    end		
	end
end
