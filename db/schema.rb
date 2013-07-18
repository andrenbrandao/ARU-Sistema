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

ActiveRecord::Schema.define(:version => 20130717205933) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "admins", :force => true do |t|
    t.string   "email",              :default => "", :null => false
    t.string   "encrypted_password", :default => "", :null => false
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",    :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "username"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true

  create_table "cursos", :force => true do |t|
    t.string "nome"
  end

  create_table "moradores", :force => true do |t|
    t.string   "nome"
    t.string   "sobrenome"
    t.string   "curso"
    t.integer  "ano_de_ingresso"
    t.string   "ra"
    t.string   "universidade"
    t.integer  "republica_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "email"
    t.string   "celular"
    t.boolean  "representante",   :default => false, :null => false
    t.string   "apelido"
    t.boolean  "exmorador",       :default => false, :null => false
    t.integer  "curso_id"
    t.datetime "data_de_saida"
  end

  create_table "republicas", :force => true do |t|
    t.string   "nome"
    t.string   "tipo"
    t.integer  "ano_de_fundacao"
    t.text     "descricao"
    t.string   "endereco"
    t.string   "telefone"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "numero_de_moradores"
    t.string   "email",                     :default => "",    :null => false
    t.string   "encrypted_password",        :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "logotipo"
    t.boolean  "approved",                  :default => false, :null => false
    t.integer  "numero"
    t.string   "campea_interreps"
    t.boolean  "presente_reunioes"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "has_inserted_ex_moradores", :default => false, :null => false
  end

  add_index "republicas", ["approved"], :name => "index_republicas_on_approved"
  add_index "republicas", ["confirmation_token"], :name => "index_republicas_on_confirmation_token", :unique => true
  add_index "republicas", ["email"], :name => "index_republicas_on_email", :unique => true
  add_index "republicas", ["reset_password_token"], :name => "index_republicas_on_reset_password_token", :unique => true

end
