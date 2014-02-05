#encoding: utf-8

class Admin::ComentariosController < AdminController
	load_and_authorize_resource

	def index
		@servico = Servico.find(params[:servico_id])
		@comentarios = @servico.comentarios

		@new_comentario = @servico.comentarios.build

		respond_to do |format|
			format.html
			format.js
		end
	end

	def destroy
		@comentario = Comentario.find(params[:id])

		respond_to do |format|
			if @comentario.destroy
				flash[:notice] = "Comentário deletado!"
				format.html { redirect_to admin_servicos_path }
			else
				flash[:notice] = "Comentário não pode ser deletado."
				format.html { redirect_to admin_servicos_path }
			end
		end
	end

end
