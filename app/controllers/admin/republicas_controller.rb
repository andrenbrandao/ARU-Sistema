class Admin::RepublicasController < AdminController
 helper_method :sort_column, :sort_direction


 def index
  @republicas_header = true

  @republicas = Republica.search(params[:search]).where(approved: true).page(params[:page]).order(sort_column + ' ' + sort_direction)

  respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @republicas }
      format.js # index.js.erb
    end
  end

  def unapproved_index
    @republicas = Republica.search(params[:search]).where(approved: false).page(params[:page]).order(sort_column + ' ' + sort_direction)

    respond_to do |format|
     format.html
     format.json { render json: @republicas }
     format.js 
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