class Categoria < ActiveRecord::Base
	has_many :categorizations, dependent: :destroy
	has_many :servicos, through: :categorizations
	belongs_to :republica

	before_save :titleize_nome
	before_destroy :find_servicos
	after_destroy :destroy_servicos_sem_categorias

	attr_accessible :nome

	validates :nome, presence: true, uniqueness: true

	private

	def titleize_nome
		self.nome = self.nome.titleize
	end

	def find_servicos
		@servicos = self.servicos
	end

	def destroy_servicos_sem_categorias
		@servicos.each do |serv|
			serv.destroy if serv.categorias.count.zero?
		end  
	end

end
