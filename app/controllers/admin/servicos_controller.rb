#encoding: utf-8

class Admin::ServicosController < AdminController

	def index
		@servicos_header = true

		if params[:categoria].present?
			@servicos = Servico.includes(:categorias).where('categorias.nome = ?', params[:categoria]).includes(:republica).order('avaliacao desc').page(params[:page])
		else
			@servicos = Servico.includes(:categorias).includes(:republica).order('avaliacao desc').page(params[:page])
		end

		if params[:republica] == 'true'
			@servicos = @servicos.where(republica_id: current_republica.id)
		end

		@categorias = Categoria.order('nome')


		respond_to do |format|
			format.html 
			format.js
		end
	end

	def edit
		@servico = Servico.find(params[:id])

		respond_to do |format|
			format.html 
		end
	end

	def update
		@servico = Servico.find(params[:id])

		respond_to do |format|
			if @servico.update_attributes(params[:servico])
				format.html { redirect_to admin_servicos_path, notice: 'Serviço atualizado.' }
			else
				format.html { render 'edit'  }
			end
		end
	end

	def destroy
		@servico = Servico.find(params[:id])

		respond_to do |format|
			if @servico.destroy
				flash[:notice] = "Serviço deletado!"
				format.html { redirect_to admin_servicos_path }
			else
				flash[:notice] = "Serviço não pode ser deletado."
				format.html { redirect_to admin_servicos_path }
			end
		end
	end

end
