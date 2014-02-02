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
		@servico = Servico.new

		respond_to do |format|
			format.html 
		end
	end

	def create
		@republica = current_republica
		@servico = @republica.servicos.build(params[:servico])

		respond_to do |format|
			if @servico.save
				format.html { redirect_to servicos_path, notice: 'Serviço criado com sucesso.' }
			else
				format.html { render action: "new" }
			end
		end
	end

end
