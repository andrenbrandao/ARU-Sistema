#encoding: utf-8

class Morador < ActiveRecord::Base
	belongs_to :republica, :inverse_of => :moradores
	validates :republica, presence: true

	attr_accessible :ano_de_ingresso, :curso, :nome, :ra, :republica_id, :sobrenome, :universidade
	attr_accessible :email, :celular, :representante, :apelido

	UNIVERSIDADE = [ "Unicamp", "PUC", "Facamp", "Outra" ]

	validates :nome, presence: true
	validates :sobrenome, presence: true
	validates :universidade, presence: true, inclusion: UNIVERSIDADE
	validates :ra, presence: true, uniqueness: true, numericality: {only_integer: true },
			   length: {in: 5..6, message: 'RA inválido'}, :if => :is_unicamp?
	validates :curso, presence: true
	validates :ano_de_ingresso, presence: true
	validates :email, presence: true, :if => :is_representante?
	validates :celular, presence: true, :if => :is_representante?
	
private

	def is_unicamp?
		universidade == "Unicamp"
	end

	def is_representante?
		representante == true		
	end

end
