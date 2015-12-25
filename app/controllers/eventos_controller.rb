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

    error = false
    # So faz verificacoes se houver valores positivios
    if [@evento.max1_ex, @evento.max1_ag, @evento.max2_ex, @evento.max2_ag].max != 0
      error = check_number_exmoradores_agregados(params[:evento], @evento)
    end

    # Checa numero de moradores
    error = check_number_moradores(params[:evento], @evento) || error

    respond_to do |format|
      if error == false && @evento.update_attributes(params[:evento])
        format.html { redirect_to eventos_path, notice: 'Inscrição efetuada com sucesso.' }
        format.json { head :no_content }
      else
    # Cria numero de agregados que podem ser inscritos
      max_ag = [@evento.max1_ag, @evento.max2_ag].max
      (max_ag - @evento.evento_republicas.count).times do |i|
        @evento.evento_republicas.build
      end

        format.html { render action: "edit" }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @evento = Evento.find(params[:id])

    respond_to do |format|
      if @evento.cancelar_inscricao(current_republica)
        format.html { redirect_to eventos_path, notice: 'Inscrição Cancelada!' }
        format.json { head :no_content }
      else
        format.html { redirect_to eventos_path, :alert => "A inscrição não pôde ser cancelada."  }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_number_exmoradores_agregados(params, evento)
    opcao_exag = params[:opcao_exag]
    exmorador_ids = params[:exmorador_ids]
    exmorador_ids.reject!(&:empty?)


    # Se houver agregados nas opcoes
    if evento.max1_ag != 0 || evento.max2_ag != 0
      count = 0
      params[:evento_republicas_attributes].each do |id, a|
        if !a[:agregado].empty?
          count += 1
        end
      end
    end
    if opcao_exag == '1'
      if exmorador_ids.size > evento.max1_ex
        evento.errors.add(:base, "Você só pode escolher no máximo #{evento.max1_ex} ex-moradores")
      end
      if count > evento.max1_ag
        evento.errors.add(:base, "Você só pode escolher no máximo #{evento.max1_ag} agregados")
      end

    elsif opcao_exag == '2'
      if exmorador_ids.size > evento.max2_ex
        evento.errors.add(:base, "Você só pode escolher no máximo #{evento.max2_ex} ex-moradores")
      end

      if count > evento.max2_ag
        evento.errors.add(:base, "Você só pode escolher no máximo #{evento.max2_ag} agregados")
      end

    else
      evento.errors.add(:base, "Você deve escolher uma das opções")
    end

    return true if evento.errors.present?
    return false

  end

  def check_number_moradores(params, evento)
    morador_ids = params[:morador_ids]
    morador_ids.reject!(&:empty?)

    if morador_ids.size == 0
      evento.errors.add(:base, "Você deve escolher ao menos 1 morador")
      return true
    end

    return false
  end

end
