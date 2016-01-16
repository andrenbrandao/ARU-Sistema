#encoding: utf-8

class Admin::EventoMoradoresController < AdminController

	def index
		@evento = Evento.find(params[:evento_id])
		@evento_jogadores = @evento.evento_jogadores

		respond_to do |format|
			format.html
			format.json { render json: @evento_jogadores }
		end
	end

	def edit
		@evento = Evento.find(params[:evento_id])
		@evento_jogadores = @evento.evento_jogadores
	end

	def create
		@evento = Evento.find(params[:evento_id])
		@republicas = Republica.where(approved: true).order

		if params[:tipo] == "morador"
			erro = "ex-morador"
		else
			erro = "morador"
		end

		begin
			result = @evento.update_attributes(params[:evento])
		rescue ActiveRecord::RecordInvalid => e
			@evento.errors.add(:base, "'#{e.record.morador.full_name}' já está inscrito no evento como #{erro}")
		end

		respond_to do |format|
			if result
				format.html { redirect_to admin_eventos_path, notice: 'Jogadores selecionados com sucesso.' }
				format.json { head :no_content }
			else
				if params[:tipo] == "morador"
					format.html { render action: "add_moradores" }
				else
					format.html { render action: "add_exmoradores" }
				end
				format.json { render json: @evento.errors, status: :unprocessable_entity }
			end
		end
	end

	def add_moradores
		@evento = Evento.find(params[:evento_id])
		@republicas = Republica.where(approved: true).order

		respond_to do |format|
      		format.html # new.html.erb
      		format.json { render json: @evento }
 	 	end
	end

	def add_exmoradores
		@evento = Evento.find(params[:evento_id])
		@republicas = Republica.where(approved: true).order

		respond_to do |format|
      		format.html # new.html.erb
      		format.json { render json: @evento }
 	 	end
	end

end