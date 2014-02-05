#encoding: utf-8

class Admin::CategoriasController < AdminController

	def index
		@categorias = Categoria.includes(:servicos).order(:nome)

		respond_to do |format|
			format.html
		end	
	end

	def destroy
		@categoria = Categoria.find(params[:id])

		respond_to do |format|
			if @categoria.destroy
				flash[:notice] = "Categoria deletada!"
				format.html { redirect_to admin_categorias_path }
			else
				flash[:notice] = "Categoria não pode ser deletada."
				format.html { redirect_to admin_categorias_path }
			end
		end
	end

end
