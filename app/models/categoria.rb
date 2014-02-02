class Categoria < ActiveRecord::Base
	has_many :categorizations
	has_many :servicos, through: :categorization
	belongs_to :republica

	attr_accessible :nome
end
