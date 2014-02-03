class Categoria < ActiveRecord::Base
	has_many :categorizations, dependent: :destroy
	has_many :servicos, through: :categorizations
	belongs_to :republica

	attr_accessible :nome

	validates :nome, presence: true, uniqueness: true
end
