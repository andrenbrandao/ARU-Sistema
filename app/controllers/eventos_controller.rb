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
    authorize! :edit, @evento

    @modalidades = @evento.modalidades.group_by{ |d| d[:tipo]}

    # Seleciona somente os ex-moradores que podem jogar
    # No caso do InterReps
    @exmoradores_ajogar = find_exmoradores_aptos(@evento, @republica)

    # Cria numero de agregados que podem ser inscritos
    @agregados = @evento.evento_republicas.find_with_agregados(current_republica)
    max_ag = [@evento.max1_ag, @evento.max2_ag].max
    (max_ag - @agregados.count).times do |i|
      @agregados << @evento.evento_republicas.build
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
    @modalidades = @evento.modalidades.group_by{ |d| d[:tipo]}

    # raise error

    error = false
    # So faz verificacoes se houver valores positivios
    if [@evento.max1_ex, @evento.max1_ag, @evento.max2_ex, @evento.max2_ag].max != 0
      error = check_number_exmoradores_agregados(params[:evento], @evento)
    end

    # Checa numero de moradores
    error = check_number_moradores(params[:evento], @evento) || error

    respond_to do |format|
      if updates_all_subelements(error, @evento, params[:evento])
        format.html { redirect_to eventos_path, notice: 'Inscrição efetuada com sucesso.' }
        format.json { head :no_content }
      else
        # Seleciona somente os ex-moradores que podem jogar
        # No caso do InterReps
        @exmoradores_ajogar = find_exmoradores_aptos(@evento, @republica)

          # Cria numero de agregados que podem ser inscritos
          @agregados = @evento.evento_republicas.find_with_agregados(current_republica)
          max_ag = [@evento.max1_ag, @evento.max2_ag].max

          if max_ag != 0
            lista = params[:evento][:evento_republicas_attributes]
            lista = lista.drop(1)
            (max_ag - @agregados.count).times do |i|
              @agregados << @evento.evento_republicas.build(agregado: lista.first.last.try(:[],:agregado))
              lista = lista.drop(1)
            end
          end
        format.html { render action: "edit" }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @evento = Evento.find(params[:id])
    authorize! :destroy, @evento

    respond_to do |format|
      if destroy_modalidades(@evento) && @evento.cancelar_inscricao(current_republica)
        format.html { redirect_to eventos_path, notice: 'Inscrição Cancelada!' }
        format.json { head :no_content }
      else
        format.html { redirect_to eventos_path, :alert => "A inscrição não pôde ser cancelada."  }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_number_exmoradores_agregados(params, evento)
    opcao_exag = params[:evento_republicas_attributes].first.last[:opcao]
    exmorador_ids = params[:exmorador_ids]
    exmorador_ids.reject!(&:empty?) if exmorador_ids.present?

    # raise error

    # Se houver agregados nas opcoes
    p = params[:evento_republicas_attributes].drop(1)
    count = 0
    if evento.max1_ag != 0 || evento.max2_ag != 0
     p.each do |id, a|
        if !a[:agregado].empty?
          count += 1
        end
      end
    end
    if opcao_exag == '1'
      if exmorador_ids.present? && (exmorador_ids.size > evento.max1_ex)
        evento.errors.add(:base, "Você só pode escolher no máximo #{evento.max1_ex} ex-moradores")
      end
      if count > evento.max1_ag
        evento.errors.add(:base, "Você só pode escolher no máximo #{evento.max1_ag} agregados")
      end

    elsif opcao_exag == '2'
      if exmorador_ids.present? && (exmorador_ids.size > evento.max2_ex)
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

  def inscreve_modalidades(params, evento)
    play_mods = params[:play_mods_ids].reject(&:empty?)

    # devolve erro se não houver modalidades escolhidas
    if play_mods.empty?
      evento.errors.add(:base, "Você deve escolher pelo menos 1 modalidade")
      return false
    end

    disponiveis_id = evento.evento_modalidades.collect(&:id) # Todos evento_modalidades disponiveis pra esse evento

    remover = disponiveis_id - play_mods

    Evento.transaction do
      # Remove todas as outras modalidades que nao foram escolhidas
      RepublicaEventoModalidade.where(republica_id: current_republica.id, evento_modalidade_id: remover).destroy_all

      # Cria se nao existir
      play_mods.each do |id|
        RepublicaEventoModalidade.where(republica_id: current_republica.id, evento_modalidade_id: id).first_or_create!
      end
    end

    return true
  end

  def updates_all_subelements(error, evento, params)
    # Tenta inscrever modalidades
    result = false
    Evento.transaction do
      if evento.modalidades.any?
        inscritas = inscreve_modalidades(params, evento)
      else
        inscritas = true
      end

      result = (error == false && inscritas == true && evento.update_attributes(params))

      if inscritas != true
        raise ActiveRecord::Rollback
        return false
      end
    end

    return result
  end

  def destroy_modalidades(evento)
    disponiveis_id = evento.evento_modalidades.collect(&:id) # Todos evento_modalidades disponiveis pra esse evento

    Evento.transaction do
      # Remove todas as modalidades para essa republica nesse evento
      RepublicaEventoModalidade.where(republica_id: current_republica.id, evento_modalidade_id: disponiveis_id).destroy_all
    end

    return true
  end

  def find_exmoradores_aptos(evento, republica)
    if evento.nome.downcase == "interreps"
      exmoradores = republica.exmoradores
      # Retorna interreps anteriores ao atual com seus moradores que jogaram
      eventos = Evento.joins(:evento_moradores).where("lower(nome) = 'interreps' AND ano < ?", evento.ano).uniq

      # Busca todos os morador_ids desses eventos
      jogador_ids = eventos.map(&:evento_moradores).flatten.map(&:morador_id)

      # Seleciona exmoradores que podem jogar
      exmoradores_ajogar = exmoradores.where(id: jogador_ids)

      return exmoradores_ajogar
    end
  end

end
