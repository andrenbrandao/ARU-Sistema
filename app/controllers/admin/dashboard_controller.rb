class Admin::DashboardController < AdminController
	helper_method :sort_column, :sort_direction


	def index
		@republicas = Republica.where(approved: false).page(params[:page]).order(sort_column + ' ' + sort_direction)
		@exmoradores = Morador.where(exmorador: true).page(params[:page])

		@dashboard_header = true

		respond_to do |format|
	      format.html # index.html.erb
	      format.js
	  end
	end

	def listadereps
		@masculinas = Republica.where(tipo: 'Masculina').order('approved DESC', :nome)
		@femininas = Republica.where(tipo: 'Feminina').order('approved DESC',:nome)
		@mistas = Republica.where(tipo: 'Mista').order('approved DESC',:nome)
	end

	private

	def sort_column
		Republica.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
	end

	def sort_direction
		%w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
	end

end