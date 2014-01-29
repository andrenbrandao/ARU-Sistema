#encoding: utf-8

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
				format.html { redirect_to admin_republica_path(@republica), notice: 'Morador foi atualizado com sucesso.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @morador.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@republica = Republica.find(params[:republica_id])
		@moradores = @republica.moradores
		@morador = Morador.find(params[:id])

		respond_to do |format|
			if @moradores.size > 3 && @morador.destroy

				format.html { redirect_to admin_republica_moradores_path(@republica), notice: 'Morador deletado!' }
				format.json { head :no_content }
			else
				format.html { redirect_to admin_republica_moradores_path(@republica), :alert => "O morador não pode ser deletado, pois a República não pode ficar com menos que 3 deles."  }
				format.json { render json: @republica.errors, status: :unprocessable_entity }
			end
		end
	end


end