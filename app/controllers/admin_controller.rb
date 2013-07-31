class AdminController < ApplicationController
	load_and_authorize_resource

	def dashboard
		@republica = Republica.where(approved: true)
		@republica.each do |republica|
			@exmoradores ||= republica.moradores.where(exmorador: true)
		end

		respond_to do |format|
	      format.html # index.html.erb
	  end
	end

	def edit_morador

		@republica = Republica.find(params[:republica_id])
		@morador = Morador.find(params[:morador_id])
	end


	### NÃO ESTÁ SENDO UTILIZADO AINDA!!! ###
	def update_morador
   		@morador = Morador.where(params[:morador_id])

	    respond_to do |format|
	      if @morador.update_without_timestamping(params[:morador])
	        format.html { redirect_to republica_path(@republica), notice: 'Morador foi atualizado com sucesso.' }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit_morador" }
	        format.json { render json: @morador.errors, status: :unprocessable_entity }
	      end
	    end
	end

end