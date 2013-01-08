# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130108010254) do

  create_table "moradores", :force => true do |t|
    t.string   "nome"
    t.string   "sobrenome"
    t.string   "curso"
    t.integer  "ano_de_ingresso"
    t.string   "ra"
    t.string   "universidade"
    t.integer  "republica_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "email"
    t.string   "celular"
    t.boolean  "representante"
  end

  create_table "republicas", :force => true do |t|
    t.string   "nome"
    t.string   "tipo"
    t.integer  "ano_de_fundacao"
    t.text     "descricao"
    t.string   "endereco"
    t.string   "telefone"
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "numero_de_moradores"
  end

end
