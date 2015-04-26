#encoding: utf-8

class EventosController < ApplicationController

  def index
    authorize! :index, Evento
    @eventos_header = true
    @eventos = Evento.order("ano DESC")

    respond_to do |format|
      format.html
      format.json { render json: @eventos }
    end
  end

  def new
    @evento = Evento.new
    @modalidades = Modalidade.all.group_by{ |d| d[:tipo]}

    respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @evento }
    end
  end

  def edit
    @republica = current_republica
    @evento = Evento.find(params[:id])
    authorize! :edit, Evento

    @modalidades = Modalidade.all.group_by{ |d| d[:tipo]}

    # Cria numero de agregados que podem ser inscritos
    max_ag = [@evento.max1_ag, @evento.max2_ag].max
    (max_ag -@evento.evento_republicas.count).times do |i|
      @evento.evento_republicas.build
    end
  end

  # def create
  #   params[:evento][:modalidade_ids].reject! { |c| c.empty? }
  #   @evento = Evento.new(params[:evento])

  #       respond_to do |format|
  #       if @evento.save
  #         format.html { redirect_to eventos_path, notice: 'Novo evento criado com sucesso!' }
  #         format.json { render json: @evento, status: :created, location: @evento }
  #       else
  #         format.html { render action: "new" }
  #         format.json { render json: @evento.errors, status: :unprocessable_entity }
  #         end
  #       end
  #   end

  def update
    @republica = current_republica
    @evento = Evento.find(params[:id])

    respond_to do |format|
      if @evento.update_attributes(params[:evento])
        format.html { redirect_to eventos_path, notice: 'Inscrição efetuada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @evento = Evento.find(params[:id])

    respond_to do |format|
      if @evento.destroy
        format.html { redirect_to admin_eventos_path, notice: 'Evento deletado!' }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_eventos_path, :alert => "O evento não pode ser deletado."  }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

end
