#encoding: utf-8

class RepublicasController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  
  # GET /republicas
  # GET /republicas.json
  def index
    @republicas_header = true

    if params[:tipo] == 'Masculina'
      @republicas = Republica.search(params[:search]).where(approved: true).where(tipo: 'Masculina').page(params[:page]).order(sort_column + ' ' + sort_direction)
    elsif params[:tipo] == 'Feminina'
      @republicas = Republica.search(params[:search]).where(approved: true).where(tipo: 'Feminina').page(params[:page]).order(sort_column + ' ' + sort_direction)
    elsif params[:tipo] == 'Mista'
      @republicas = Republica.search(params[:search]).where(approved: true).where(tipo: 'Mista').page(params[:page]).order(sort_column + ' ' + sort_direction)
    else
      @republicas = Republica.search(params[:search]).where(approved: true).page(params[:page]).order(sort_column + ' ' + sort_direction)
    end

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
    @contato = @republica.contato
    @social_info = @republica.social_information

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

 private

 def sort_column
  Republica.column_names.include?(params[:sort]) ? params[:sort] : "nome"
end

def sort_direction
 %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
end


end
