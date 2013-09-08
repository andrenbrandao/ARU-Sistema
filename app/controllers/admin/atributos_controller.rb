class Admin::AtributosController < AdminController

  def edit
    @republica = Republica.find(params[:republica_id])
  end

  def update
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

end