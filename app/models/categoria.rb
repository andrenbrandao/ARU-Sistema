class Categoria < ActiveRecord::Base
	has_many :categorizations, dependent: :destroy
	has_many :servicos, through: :categorizations
	belongs_to :republica

	before_save :titleize_nome

	attr_accessible :nome

	validates :nome, presence: true, uniqueness: true

	private

	def titleize_nome
		self.nome = self.nome.titleize
	end

end
