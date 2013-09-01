class Admin::DashboardController < AdminController
	helper_method :sort_column, :sort_direction


	def index
		@republicas = Republica.where(approved: false).page(params[:page]).order(sort_column + ' ' + sort_direction)

		@exmoradores = []

		@republicas.each do |republica|
			republica.moradores.where(exmorador: true).each do |morador|
				@exmoradores << morador
			end
		end

		@dashboard_header = true

		respond_to do |format|
	      format.html # index.html.erb
	      format.js
	  end
	end

	private

	def sort_column
		Republica.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
	end

	def sort_direction
		%w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
	end

end