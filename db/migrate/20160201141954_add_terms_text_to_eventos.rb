class AddTermsTextToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :terms_text, :text
  end
end
