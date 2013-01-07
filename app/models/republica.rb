#encoding: utf-8

class Republica < ActiveRecord::Base
	has_many :moradores, :dependent => :destroy, :inverse_of => :republica


	accepts_nested_attributes_for :moradores, :allow_destroy => true

	attr_accessible :ano_de_fundacao, :descricao, :endereco, :nome, :password, :password_confirmation
	attr_accessible :telefone, :tipo, :username, :numero_de_moradores, :moradores_attributes

	TIPO_DE_REP = [ "Masculina", "Feminina", "Mista"]

	validates :nome, presence: true, uniqueness: true
	validates :tipo, presence: true, inclusion: TIPO_DE_REP
	validates :ano_de_fundacao, presence: true
	validates :descricao, presence: true, length: {minimum: 140}
	validates :endereco, presence: true
	#validates :telefone, presence: true
	validates :username, presence: true, uniqueness: true

	validate :min_of_moradores
	validate :max_of_moradores
	validate :has_one_representante


	private

	def min_of_moradores
		if self.moradores.reject(&:marked_for_destruction?).length < 3
			self.errors.add(:base, "República deve ter no mínimo 3 moradores")
		end
	end

	def max_of_moradores
		if self.moradores.reject(&:marked_for_destruction?).length > 20
			self.errors.add(:base, "República possui mais de 20 moradores")
		end
	end

	def has_one_representante
		count = 0
		self.moradores.reject(&:marked_for_destruction?).each do |f|
			if f.representante == true
				count += 1
			end
		end

		if count == 0
			self.errors.add(:base, "Selecione um representante")
		end
	end


	has_secure_password
end
