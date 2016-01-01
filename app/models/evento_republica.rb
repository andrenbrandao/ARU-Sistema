#encoding: utf-8

class EventoRepublica < ActiveRecord::Base
  belongs_to :evento
  belongs_to :republica
  attr_accessible :agregado, :republica_id, :opcao

  validates :evento, presence: true
  # validates :agregado, uniqueness: {scope: [:evento_id, :republica_id]}
  # validates :opcao, uniqueness: {scope: [:evento_id, :republica_id]}
  validates :republica, presence: true
  validates :opcao, presence: true, unless: :agregado_present?
  validates :agregado, presence: true, unless: :opcao_present?

  validate :only_one_option_per_event, if: :opcao_present?
  validate :check_agregado_uniqueness, if: :agregado_present?

  def agregado_present?
  	self.agregado.present?
  end

  def opcao_present?
  	self.opcao.present?
  end

  def only_one_option_per_event
  	matches = EventoRepublica.where("republica_id = ? AND evento_id = ? AND opcao IS NOT NULL", self.republica_id, self.evento.id)

  	if self.persisted?
  		matches = matches.where("id != ?", self.id)
  	end

  	if matches.exists?
  		self.errors.add(:base, 'Já há uma opção de escolha.')
  	end
  end

  def check_agregado_uniqueness
  	matches = EventoRepublica.where("republica_id = ? AND evento_id = ? AND agregado = ?", self.republica_id, self.evento.id, self.agregado)

  	if self.persisted?
  		matches = matches.where("id != ?", self.id)
  	end

  	if matches.exists?
  		self.errors.add(:base, 'Já há um agregado com esse nome.')
  	end
  end

  def self.find_with_option(republica)
  	where("republica_id = ? AND opcao IS NOT NULL", republica.id)
  end

  def self.find_with_agregados(republica)
  	where("republica_id = ? AND agregado IS NOT NULL", republica.id)
  end


end
