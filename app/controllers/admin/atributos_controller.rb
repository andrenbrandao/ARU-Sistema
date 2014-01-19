class Admin::AtributosController < AdminController

  def edit
    @republica = Republica.find(params[:republica_id])
    @republica.interreps_vencidos.build
  end

  def update
    @republica = Republica.find(params[:republica_id])

    respond_to do |format|
        ## Initializer utilizado para NÃO ALTERAR os TIMESTAMPS - como UPDATED_AT ##
        if @republica.update_attributes(params[:republica])
          format.html { redirect_to admin_republica_path(@republica), notice: 'Republica was successfully updated.' }
        else
         format.html { render action: "edit" }
       end
     end
   end

end