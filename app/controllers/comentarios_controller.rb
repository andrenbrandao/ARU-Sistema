#encoding: utf-8

class ComentariosController < ApplicationController
	load_and_authorize_resource

	def new
		@servico = Servico.find(params[:servico_id])
		@new_comentario = @servico.comentarios.build

		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
		@servico = Servico.find(params[:servico_id])
		@comentario = @servico.comentarios.build(params[:comentario])
		@comentario.republica = current_republica
		@new_comentario = @servico.comentarios.build
		@comentarios = @servico.comentarios

		respond_to do |format|
			if @comentario.save
				format.html { redirect_to servicos_path, notice: 'Comentário criado com sucesso.' }
				format.js
			else
				format.html { render action: "new" }
				format.js
			end
		end
	end

	def index
		@servico = Servico.find(params[:servico_id])
		@comentarios = @servico.comentarios

		@new_comentario = @servico.comentarios.build

		respond_to do |format|
			format.html
			format.js
		end
	end

end
