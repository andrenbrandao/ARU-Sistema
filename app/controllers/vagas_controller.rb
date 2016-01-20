class VagasController < RepublicaController
	load_and_authorize_resource :republica
	load_and_authorize_resource :vaga, :through => :republica, :singleton => true

	def update
		@republica = Republica.find(params[:republica_id])
		@vaga = @republica.vaga

		if params[:acao] == 'abrir'
			@vaga.abertas = Time.now
		else
			@vaga.abertas = nil
		end

		respond_to do |format|
			if @vaga.save
				format.html { redirect_to republica_path(@republica), notice: 'Vagas atualizadas.' }
				format.json { head :no_content }
			else
				format.html { redirect_to republica_path(@republica), :alert => "Ocorreu um erro."  }
				format.json { render json: @vaga.errors, status: :unprocessable_entity }
			end	
		end
	end

end