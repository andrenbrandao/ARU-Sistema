class Admin::ExmoradoresController < AdminController

	def index
		@republica = Republica.find(params[:republica_id])
		@exmoradores = @republica.exmoradores.order(:ano_de_ingresso)

		respond_to do |format|
			format.html
			format.json { render json: @moradores }
		end
	end

	def edit
		@republica = Republica.find(params[:republica_id])
		@exmorador = Morador.is_exmorador.find(params[:id])
	end

	def update
		@republica = Republica.find(params[:republica_id])
		@exmorador = Morador.is_exmorador.find(params[:id])

		respond_to do |format|
			if @exmorador.update_attributes(params[:morador])
				format.html { redirect_to admin_republica_exmoradores_path(@republica), notice: 'Ex-morador foi atualizado com sucesso.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @exmorador.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@republica = Republica.find(params[:republica_id])
		@exmorador = Morador.is_exmorador.find(params[:id])
		@exmorador.destroy

		respond_to do |format|
			format.html { redirect_to admin_republica_exmoradores_path(@republica), notice: 'Ex-morador deletado!' }
			format.json { head :no_content }
		end
	end


end