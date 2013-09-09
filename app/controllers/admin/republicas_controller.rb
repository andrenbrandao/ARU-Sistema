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

  @uni_hash= Hash.new

  Morador::UNIVERSIDADE.each do |uni|
    count = @moradores.where(universidade: uni).count
    percent = (count.to_f/@moradores.count)*100
    @uni_hash[uni] = percent
  end

  @uni_chart = LazyHighCharts::HighChart.new('pie') do |f|
    f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
    series = {
     :type=> 'pie',
     :name=> 'Alunos por Universidade',
     :data=>
     @uni_hash.map {|uni, percent| [uni, percent.to_f.round(1)] }
   }
   f.series(series)
   f.options[:title][:text] = "Alunos por Universidade"
   f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
   f.plot_options(:pie=>{
    :allowPointSelect=>true, 
    :cursor=>"pointer" , 
    :dataLabels=>{
      :enabled=>true,
      :color=>"black",
      :style=>{
        :font=>"13px Trebuchet MS, Verdana, sans-serif"
      }
    }
    })
 end

 @curso_hash= Hash.new

 Morador::CURSO.each do |curso|
  count = @moradores.where(curso: curso).count
  percent = (count.to_f/@moradores.count)*100
  @curso_hash[curso] = percent
end

@curso_chart = LazyHighCharts::HighChart.new('pie') do |f|
  f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
  series = {
   :type=> 'pie',
   :name=> 'Alunos por Curso',
   :data=>
   @curso_hash.map {|curso, percent| [curso, percent.to_f.round(1)] }
 }
 f.series(series)
 f.options[:title][:text] = "Alunos por Curso"
 f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
 f.plot_options(:pie=>{
  :allowPointSelect=>true, 
  :cursor=>"pointer" , 
  :dataLabels=>{
    :enabled=>true,
    :color=>"black",
    :style=>{
      :font=>"13px Trebuchet MS, Verdana, sans-serif"
    }
  }
  })
end

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