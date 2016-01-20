#encoding: utf-8

class ExmoradoresController < RepublicaController
  load_and_authorize_resource :republica
  load_and_authorize_resource :morador, :through => :republica
  skip_before_filter :check_approved_republica

  def index
    @republica = Republica.find(params[:republica_id])
    @exmoradores = @republica.exmoradores.order(:ano_de_ingresso)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exmoradores }
    end
  end

  def new
    @republica = Republica.find(params[:republica_id])
    @exmorador = @republica.moradores.build

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def create
    @republica = Republica.find(params[:republica_id])

    respond_to do |format|
      if @republica.update_attributes(params[:republica])
        format.html { redirect_to @republica, notice: 'Ex-moradores adicionados com sucesso!' }
        format.json { head :no_content }
      else
       format.html { render action: "new" }
       format.json { render json: @republica.errors, status: :unprocessable_entity }
     end
   end
 end

end