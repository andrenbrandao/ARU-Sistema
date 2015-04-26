#encoding: utf-8
class Evento < ActiveRecord::Base
  has_many :evento_modalidades, dependent: :destroy
  has_many :modalidades, through: :evento_modalidades
  has_many :evento_moradores, dependent: :destroy
  has_many :moradores, through: :evento_moradores
  has_many :evento_republicas, dependent: :destroy, inverse_of: :evento
  has_many :republicas, through: :evento_republicas

  accepts_nested_attributes_for :evento_republicas, :allow_destroy => true, :reject_if => lambda { |a| a[:agregado].blank? }

  attr_accessible :ano, :nome, :open, :max1_ex, :max1_ag, :max2_ex, :max2_ag
  attr_accessible :modalidade_ids, :morador_ids, :republicas, :evento_republicas_attributes

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

end
