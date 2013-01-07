class MoradoresController < ApplicationController
  # GET /moradores
  # GET /moradores.json
  def index
    @republica = Republica.find(params[:republica_id])
    @moradores = @republica.moradores

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @moradores }
    end
  end

  # GET /moradores/1
  # GET /moradores/1.json
  def show
    @morador = Morador.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @morador }
    end
  end

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
    @morador = Morador.find(params[:id])
  end

  # POST /moradores
  # POST /moradores.json
  def create
    @republica = Republica.find(params[:republica_id])
    @morador = @republica.moradores.build(params[:morador])

    respond_to do |format|
      if @morador.save
        format.html { redirect_to @morador, notice: 'Morador was successfully created.' }
        format.json { render json: @morador, status: :created, location: @morador }
      else
        format.html { render action: "new" }
        format.json { render json: @morador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /moradores/1
  # PUT /moradores/1.json
  def update
    @republica = Republica.find(params[:republica_id])
    @morador = Morador.find(params[:id])

    respond_to do |format|
      if @morador.update_attributes(params[:morador])
        format.html { redirect_to republica_morador_path(@republica, @morador), notice: 'Morador was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @morador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moradores/1
  # DELETE /moradores/1.json
  def destroy
    @republica = Republica.find(params[:republica_id])
    @moradores = @republica.moradores.all
    @morador = Morador.find(params[:id])

    if @moradores.size > 3 
      @morador.destroy
      flash[:notice] = "Morador destroyed"
    else 
      flash[:notice] = "Must have more than 3 moradores"
    end

    respond_to do |format|
      format.html { redirect_to republica_moradores_url }
      format.json { head :no_content }
    end
  end

end
