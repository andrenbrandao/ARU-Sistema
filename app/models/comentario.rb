class Comentario < ActiveRecord::Base
	belongs_to :republica
	belongs_to :servico

	attr_accessible :texto

	validates :texto, presence: true
end
