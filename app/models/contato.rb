#encoding: utf-8

class Contato < ActiveRecord::Base
	belongs_to :republica

	attr_accessible :email, :nome1, :tel1, :nome2, :tel2

	validates_format_of :email, :with => /^\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b$/i, message: 'Email inválido', allow_blank: true
	
	validates :nome1, presence: {scope: :tel1, message: "Preencha o nome da pessoa."}, :unless => lambda { self.tel1.blank? }
	validates :tel1, presence: {scope: :nome1, message: "Preencha o telefone correspondente."}, :unless => lambda { self.nome1.blank? }

	validates :nome2, presence: {scope: :tel2, message: "Preencha o nome da pessoa."}, :unless => lambda { self.tel2.blank? }
	validates :tel2, presence: {scope: :nome2, message: "Preencha o telefone correspondente."}, :unless => lambda { self.nome2.blank? }
end
