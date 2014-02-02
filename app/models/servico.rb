#encoding: utf-8

class Servico < ActiveRecord::Base
	before_save :titleize_endereco

	has_many :categorizations
	has_many :categorias, through: :categorization
	belongs_to :republica

	attr_accessible :avaliacao, :endereco, :descricao, :email, :nome, :preco,
	:site, :tel1, :tel2

	validates :avaliacao, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
	validates :preco, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
	validates_format_of :email, :with => /^\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b$/i, message: 'Email inválido', allow_blank: true
	validates :nome, presence: true
	validates :descricao, length: {minimum: 40}, allow_blank: true
	validates_format_of :site, :with => URI::regexp(%w(http https)), message: "Por favor, insira o link completo, com http(s).", allow_blank: true


	private

	def titleize_endereco
		if self.endereco?
			self.endereco = self.endereco.titleize
		end
	end
end
