#encoding: utf-8

class RepublicasController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  
  # GET /republicas
  # GET /republicas.json
  def index
    @republicas_header = true

    @republicas = Republica.search(params[:search]).where(approved: true).page(params[:page]).order(sort_column + ' ' + sort_direction)


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @republicas }
      format.js # index.js.erb
    end
  end

  # GET /republicas/1
  # GET /republicas/1.json
  def show
    @republica = Republica.find(params[:id])

    @republica.moradores.each do |morador|
      if morador.representante == true
        @representante = morador
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @republica }
    end
  end

  # GET /republicas/new
  # GET /republicas/new.json
  def new
    @republica = Republica.new
    @republica.moradores.build


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @republica }
    end
  end

  # POST /republicas
  # POST /republicas.json
  def create
    @republica = Republica.new(params[:republica])

    respond_to do |format|
      if @republica.save

        format.html { redirect_to @republica, notice: 'Republica was successfully created.' }
        format.json { render json: @republica, status: :created, location: @republica }
      else
        format.html { render action: "new" }
        format.json { render json: @republica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /republicas/1
  # DELETE /republicas/1.json
  def destroy
    @republica = Republica.find(params[:id])
    @republica.destroy

    respond_to do |format|
      format.html { redirect_to republicas_url }
      format.json { head :no_content }
    end
  end

  ############################################
  ####### FUNÇÕES ADICIONADAS POR MIM ########
  ############################################

  def edit_atributos
    @republica = Republica.find(params[:republica_id])
  end

  def atualizar_atributos
    @republica = Republica.find(params[:republica_id])

    respond_to do |format|
        ## Initializer utilizado para NÃO ALTERAR os TIMESTAMPS - como UPDATED_AT ##
        if @republica.update_without_timestamping(params[:republica])
          format.html { redirect_to @republica, notice: 'Republica was successfully updated.' }
        else
         format.html { render action: "edit_attributos" }
       end
     end
   end

   def index_exmoradores
    @republica = Republica.find(params[:republica_id])
    @exmoradores = @republica.moradores.where(exmorador: true)

      # comando necessário para que CANCAN funcione!
      authorize! :index_exmoradores, @republica

      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exmoradores }
    end
  end

  def approve
    @republica = Republica.find(params[:republica_id])

    respond_to do |format|
      if @republica.update2_without_timestamping(:approved, 'true')
        RepublicaMailer.welcome_email(@republica).deliver
        format.html { redirect_to republicas_path, notice: 'Republica aprovada.' }
        format.json { head :no_content }
      else
       format.html { render action: "index" }
       format.json { render json: @republica.errors, status: :unprocessable_entity }
     end
   end

 end


 def disapprove
  @republica = Republica.find(params[:republica_id])

  respond_to do |format|
    if @republica.update2_without_timestamping(:approved, 'false')
      RepublicaMailer.disapprove_email(@republica).deliver
      format.html { redirect_to republicas_path, notice: 'Republica desaprovada.' }
      format.json { head :no_content }
    else
     format.html { render action: "index" }
     format.json { render json: @republica.errors, status: :unprocessable_entity }
   end
 end
end

def statistics
  @republica = Republica.find(params[:republica_id])
  @moradores = @republica.moradores.where(exmorador: false)

  respond_to do |format|
    format.html 
  end
end

def add_exmoradores
  @republica = Republica.find(params[:republica_id])
  @republica.moradores.build
    # comando necessário para que CANCAN funcione!
    authorize! :add_exmoradores, @republica

    respond_to do |format|
     if @republica.has_inserted_ex_moradores == FALSE
      format.html # index.html.erb
    else
      format.html { redirect_to @republica, alert: 'Essa ação só pode ser executada uma vez.' }
    end
  end
end

def add_exmoradores_update
  @republica = Republica.find(params[:republica_id])

  respond_to do |format|
    if @republica.update_attributes(params[:republica])
      format.html { redirect_to @republica, notice: 'Republica was successfully updated.' }
      format.json { head :no_content }
    else
     format.html { render action: "add_exmoradores" }
     format.json { render json: @republica.errors, status: :unprocessable_entity }
   end
 end
end

private

def sort_column
  Republica.column_names.include?(params[:sort]) ? params[:sort] : "nome"
end

def sort_direction
 %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
end


end
