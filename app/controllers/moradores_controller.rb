#encoding: utf-8

class MoradoresController < ApplicationController
  load_and_authorize_resource :republica
  load_and_authorize_resource :morador, :through => :republica
  # GET /moradores
  # GET /moradores.json
  def index
    @republica = Republica.find(params[:republica_id])
    @moradores = @republica.moradores.atual.order(:ano_de_ingresso)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @moradores }
    end
  end

  # GET /moradores/1
  # GET /moradores/1.json
  # def show
  #   @morador = Morador.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @morador }
  #   end
  # end

  # GET /moradores/new
  # GET /moradores/new.json
  def new
    @republica = Republica.find(params[:republica_id])
    @morador = @republica.moradores.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @morador }
      format.js
    end
  end

  # GET /moradores/1/edit
  def edit
    @republica = Republica.find(params[:republica_id])
  end

  # POST /moradores
  # POST /moradores.json
  def create
    @republica = Republica.find(params[:republica_id])

    respond_to do |format|
      if @republica.update_attributes(params[:republica])
        format.html { redirect_to @republica, notice: 'Novos moradores criados com sucesso!' }
        format.json { render json: @republica, status: :created, location: @republica }
      else
        format.html { render action: "new" }
        format.json { render json: @republica.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /moradores/1
  # PUT /moradores/1.json
  def update
    @republica = Republica.find(params[:republica_id])

    respond_to do |format|
      if @republica.update_attributes(params[:republica])
        format.html { redirect_to republica_moradores_path(@republica), notice: 'Moradores atualizados com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @republica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moradores/1
  # DELETE /moradores/1.json
  def destroy
    @republica = Republica.find(params[:republica_id])
    @moradores = @republica.moradores.atual
    @morador = Morador.find(params[:id])

    if @moradores.size > 3 
      @morador.destroy
      flash[:notice] = "Morador deletado!"
    else 
      flash[:notice] = "República não pode ter menos que 3 moradores."
    end

    respond_to do |format|
      format.html { redirect_to republica_moradores_url }
      format.json { head :no_content }
    end
  end

end
