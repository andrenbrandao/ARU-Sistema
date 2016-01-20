class SocialInformationsController < RepublicaController
	load_and_authorize_resource :republica
	load_and_authorize_resource :social_information, :through => :republica, :singleton => true
	skip_before_filter :check_approved_republica

	def edit
		@republica = Republica.find(params[:republica_id])
		@social_info = @republica.social_information
	end

	def update
		@republica = Republica.find(params[:republica_id])
		@social_info = @republica.social_information

		respond_to do |format|
			if @social_info.update_attributes(params[:social_information])
				format.html { redirect_to republica_path(@republica), notice: 'Redes sociais atualizadas.' }
				format.json { head :no_content }
			else
				format.html { render 'edit'  }
				format.json { render json: @contato.errors, status: :unprocessable_entity }
			end	
		end
	end

end