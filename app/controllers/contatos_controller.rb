class ContatosController < RepublicaController
	load_and_authorize_resource :republica
	load_and_authorize_resource :contato, :through => :republica, :singleton => true
	skip_before_filter :check_approved_republica

	def edit
		@republica = Republica.find(params[:republica_id])
		@contato = @republica.contato
	end

	def update
		@republica = Republica.find(params[:republica_id])
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