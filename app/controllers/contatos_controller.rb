class ContatosController < ApplicationController
	load_and_authorize_resource

	def show
		@republica = current_republica
		@contato = @republica.contato	
	end

	def edit
		@republica = current_republica	
		@contato = @republica.contato
	end

	def update
		@republica = current_republica
		@contato = @republica.contato

		respond_to do |format|
			if @contato.update_attributes(params[:contato])
				format.html { redirect_to republica_path(@republica), notice: 'Contatos atualizados.' }
				format.json { head :no_content }
			else
				format.html { render 'edit'  }
				format.json { render json: @contato.errors, status: :unprocessable_entity }
			end	
		end
	end

end