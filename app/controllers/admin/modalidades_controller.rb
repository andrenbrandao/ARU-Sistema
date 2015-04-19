#encoding: utf-8

class Admin::ModalidadesController < AdminController

	def index
		@modalidades_header = true
		@modalidades = Modalidade.all.group_by{ |d| d[:tipo]}

		respond_to do |format|
			format.html
			format.json { render json: @modalidades }
		end
	end

	def new
		@modalidade = Modalidade.new

		respond_to do |format|
      		format.html # new.html.erb
      		format.json { render json: @modalidade }
 	 	end
	end

	def edit
		@modalidade = Modalidade.find(params[:id])
	end

	def create
    @modalidade = Modalidade.new(params[:modalidade])

        respond_to do |format|
	      if @modalidade.save
	        format.html { redirect_to admin_modalidades_path, notice: 'Nova modalidade criada com sucesso!' }
	        format.json { render json: @modalidade, status: :created, location: @modalidade }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @modalidade.errors, status: :unprocessable_entity }
          end
        end
    end

	def update
		@modalidade = Modalidade.find(params[:id])

		respond_to do |format|
			if @modalidade.update_attributes(params[:modalidade])
				format.html { redirect_to admin_modalidades_path, notice: 'Modalidade foi atualizada com sucesso.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @modalidade.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@modalidade = Modalidade.find(params[:id])

		respond_to do |format|
			if @modalidade.destroy
				format.html { redirect_to admin_modalidades_path, notice: 'Modalidade deletada!' }
				format.json { head :no_content }
			else
				format.html { redirect_to admin_modalidades_path, :alert => "A modalidade não pode ser deletado."  }
				format.json { render json: @modalidade.errors, status: :unprocessable_entity }
			end
		end
	end


end