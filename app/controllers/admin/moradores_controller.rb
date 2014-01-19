class Admin::MoradoresController < AdminController

	def index
		@republica = Republica.find(params[:republica_id])
		@moradores = @republica.moradores

		respond_to do |format|
			format.html
			format.json { render json: @moradores }
		end
	end

	def edit
		@republica = Republica.find(params[:republica_id])
		@morador = Morador.find(params[:id])
	end

	def update
		@republica = Republica.find(params[:republica_id])
		@morador = Morador.find(params[:id])

		respond_to do |format|
			if @morador.update_attributes(params[:morador])
				format.html { redirect_to republica_path(@republica), notice: 'Morador foi atualizado com sucesso.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit_morador" }
				format.json { render json: @morador.errors, status: :unprocessable_entity }
			end
		end
	end

end