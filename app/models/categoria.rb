class Categoria < ActiveRecord::Base
	has_many :categorizations
	has_many :servicos, through: :categorizations
	belongs_to :republica

	attr_accessible :nome

	validates :nome, presence: true, uniqueness: true
end
