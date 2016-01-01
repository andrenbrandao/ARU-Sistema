#encoding: utf-8
class Evento < ActiveRecord::Base
  has_many :evento_modalidades, dependent: :destroy
  has_many :modalidades, through: :evento_modalidades

  # Condicoes para retornar apenas moradores
  has_many :evento_moradores, dependent: :destroy, :conditions => {type_of_player: false}, inverse_of: :evento
  has_many :moradores, through: :evento_moradores, :conditions => "evento_moradores.type_of_player = 'false'"

  # Condicoes para retornar apenas ex-moradores
  has_many :evento_exmoradores, class_name: "EventoMorador", source: :evento_morador, :conditions => {type_of_player: true}
  has_many :exmoradores, class_name: "Morador", source: :morador, through: :evento_exmoradores, :conditions => "evento_moradores.type_of_player = 'true'"

  # Condicoes para retornar TODOS os JOGADORES
  has_many :evento_jogadores, class_name: "EventoMorador", source: :evento_morador
  has_many :jogadores, class_name: "Morador", source: :morador, through: :evento_moradores

  # has_many :jogadores, through: :evento_exmoradores do
  #  def all_moradores
  #      where("moradores.exmorador = ? OR moradores.exmorador = ?", "f", "t")
  #  end
 # end

  has_many :evento_republicas, dependent: :destroy, inverse_of: :evento
  has_many :republicas, through: :evento_republicas

  has_many :republica_evento_modalidades, through: :evento_modalidades

  accepts_nested_attributes_for :evento_republicas, :allow_destroy => true, :reject_if => :reject_empty_opcao_agregado

  attr_accessible :ano, :nome, :open, :max1_ex, :max1_ag, :max2_ex, :max2_ag
  attr_accessible :modalidade_ids, :morador_ids, :republicas, :evento_republicas_attributes, :exmorador_ids
  attr_accessor :opcao_exag
  attr_accessible :opcao_exag
  attr_accessor :play_mods_ids
  attr_accessible :play_mods_ids

  validates :ano, presence: true
  validates :nome, presence: true
  # validates :nome, uniqueness: {scope: :ano}
  validate :check_uniqueness_name_and_year
  before_create :repeat_old_names

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

  def reject_empty_opcao_agregado(attributes)
    exists = attributes['id'].present?
    empty = attributes[:agregado].blank? && attributes[:opcao].blank?
    attributes.merge!({:_destroy => 1}) if exists and empty
    return (!exists and empty)
  end


  def repeat_old_names
    ev = []
    ev = Evento.where('lower(nome) = ?', self.nome.downcase)

    if ev.any?
      self.nome = ev.first.nome
    end
  end

  def inscrito?(republica)
    if republica.eventos.include?(self)
      return true
    else
      return false
    end
  end

  def cancelar_inscricao(republica)
    # Deletar Moradores Inscritos
    moradores_ids = republica.moradores.collect(&:id)
    exmoradores_ids = republica.exmoradores.collect(&:id)
    todos_ids = moradores_ids + exmoradores_ids

    Evento.transaction do

      self.evento_jogadores.where(morador_id: todos_ids).destroy_all

      # Deletar Agregados Inscritos
      self.evento_republicas.where(republica_id: republica.id).destroy_all

      # Deletar Modalidades Inscritas
      self.republica_evento_modalidades.where(republica_id: republica.id).destroy_all
    end

    return true
  end

end
