class Admin::RepublicasController < AdminController
 helper_method :sort_column, :sort_direction


 def index
  @republicas_header = true

  if params[:approved] == 'false'
    @republicas = Republica.search(params[:search]).where(approved: false).page(params[:page]).order(sort_column + ' ' + sort_direction)
  else
    @republicas = Republica.search(params[:search]).where(approved: true).page(params[:page]).order(sort_column + ' ' + sort_direction)
  end

  respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @republicas }
      format.js # index.js.erb
    end
  end

  def edit
    @republica = Republica.find(params[:id])
  end

  def update
    @republica = Republica.find(params[:id])

    ## UPDATE UTILIZADO POR ADMIN! ##
    ## por isso, há o update_without_timestamping ##
    respond_to do |format|
      if @republica.update_without_timestamping(params[:republica])
        format.html { redirect_to @republica, notice: 'Republica was successfully updated.' }
        format.json { head :no_content }
      else
       format.html { render action: "edit" }
       format.json { render json: @republica.errors, status: :unprocessable_entity }
     end
   end
 end

 def approve
  @republica = Republica.find(params[:republica_id])

  respond_to do |format|
    if @republica.update2_without_timestamping(:approved, 'true')
      RepublicaMailer.welcome_email(@republica).deliver
      format.html { redirect_to admin_dashboard_index_path, notice: 'Republica aprovada.' }
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
      format.html { redirect_to admin_dashboard_index_path, notice: 'Republica desaprovada.' }
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

private

def sort_column
  Republica.column_names.include?(params[:sort]) ? params[:sort] : "nome"
end

def sort_direction
  %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
end

end