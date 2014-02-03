#encoding: utf-8

class ServicosController < ApplicationController
	load_and_authorize_resource

	def index
		@servicos = Servico.all

		respond_to do |format|
			format.html 
		end
	end

	def new
		@republica = current_republica
		@servico = @republica.servicos.build

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

end
