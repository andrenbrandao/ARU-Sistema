#encoding: utf-8

class Vaga < ActiveRecord::Base
	belongs_to :republica

	attr_accessible :abertas
end
