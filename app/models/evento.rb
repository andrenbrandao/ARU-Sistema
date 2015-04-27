#encoding: utf-8
class Evento < ActiveRecord::Base
  has_many :evento_modalidades, dependent: :destroy
  has_many :modalidades, through: :evento_modalidades

  # Condicoes para retornar apenas moradores
  has_many :evento_moradores, dependent: :destroy, :conditions => {type_of_player: false}
  has_many :moradores, through: :evento_moradores, :conditions => "evento_moradores.type_of_player = 'false'"

  # Condicoes para retotrnar apenas ex-moradores
  has_many :evento_exmoradores, class_name: "EventoMorador", source: :evento_morador, :conditions => {type_of_player: true}
  has_many :exmoradores, class_name: "Morador", source: :morador, through: :evento_exmoradores, :conditions => "evento_moradores.type_of_player = 'true'"

  # Condicoes para retornar TODOS os JOGADORES
  has_many :evento_jogadores, class_name: "EventoMorador", source: :evento_morador
  has_many :jogadores, class_name: "Morador", source: :morador, through: :evento_exmoradores

  # has_many :jogadores, through: :evento_exmoradores do
  #  def all_moradores
  #      where("moradores.exmorador = ? OR moradores.exmorador = ?", "f", "t")
  #  end
 # end

  has_many :evento_republicas, dependent: :destroy, inverse_of: :evento
  has_many :republicas, through: :evento_republicas

  accepts_nested_attributes_for :evento_republicas, :allow_destroy => true, :reject_if => :reject_agregado

  attr_accessible :ano, :nome, :open, :max1_ex, :max1_ag, :max2_ex, :max2_ag
  attr_accessible :modalidade_ids, :morador_ids, :republicas, :evento_republicas_attributes, :exmorador_ids

  validates :ano, presence: true
  validates :nome, presence: true
  # validates :nome, uniqueness: {scope: :ano}
  validate :check_uniqueness_name_and_year

  def check_uniqueness_name_and_year
    evs = []
    if !self.new_record?
      evs = Evento.where("id != ? AND lower(nome) = ? AND ano = ?", self.id, self.nome.downcase, self.ano)
    elsif self.nome.present? && self.ano.present?
      evs = Evento.where('lower(nome) = ? AND ano = ?', self.nome.downcase, self.ano)
    end

    if evs.any?
      self.errors.add(:base, "Já existe um evento com esse nome e ano.")
    end
  end

  def reject_agregado(attributes)
    exists = attributes['id'].present?
    empty = attributes[:agregado].blank?
    attributes.merge!({:_destroy => 1}) if exists and empty
    return (!exists and empty)
  end

end
