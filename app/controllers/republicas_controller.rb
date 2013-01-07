class RepublicasController < ApplicationController
  # GET /republicas
  # GET /republicas.json
  def index
    @republicas = Republica.order(:nome)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @republicas }
    end
  end

  # GET /republicas/1
  # GET /republicas/1.json
  def show
    @republica = Republica.find(params[:id])

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

  # GET /republicas/1/edit
  def edit
    @republica = Republica.find(params[:id])
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

  # PUT /republicas/1
  # PUT /republicas/1.json
  def update
    @republica = Republica.find(params[:id])

    respond_to do |format|
      if @republica.update_attributes(params[:republica])
        format.html { redirect_to @republica, notice: 'Republica was successfully updated.' }
        format.json { head :no_content }
      else

       format.html { render action: "edit" }
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


end
