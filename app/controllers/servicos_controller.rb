#encoding: utf-8

class ServicosController < RepublicaController
	load_and_authorize_resource

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

	def new
		@republica = current_republica
		@servico = @republica.servicos.build
		@categoria = @servico.categorias.build

		respond_to do |format|
			format.html 
		end
	end

	def create
		@republica = current_republica
		@servico = @republica.servicos.build(params[:servico])
		@servico.categorias.each do |cat|
			cat.republica = current_republica
		end

		respond_to do |format|
			if @servico.save
				format.html { redirect_to servicos_path, notice: 'Serviço criado com sucesso.' }
			else
				format.html { render action: "new" }
			end
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
				format.html { redirect_to servicos_path, notice: 'Serviço atualizado.' }
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
				format.html { redirect_to servicos_path }
			else
				flash[:notice] = "Serviço não pode ser deletado."
				format.html { redirect_to servicos_path }
			end
		end
	end

end
