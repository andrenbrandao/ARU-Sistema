class CreateModalidades < ActiveRecord::Migration
  def change
    create_table :modalidades do |t|
      t.string :nome
      t.string :tipo

      t.timestamps
    end
  end
end
