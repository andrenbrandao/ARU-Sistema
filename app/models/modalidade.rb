#encoding: utf-8

class Modalidade < ActiveRecord::Base
  has_many :evento_modalidades, dependent: :destroy
  has_many :eventos, through: :evento_modalidades

  attr_accessible :nome, :tipo

  validates :nome, presence: true
  validates :tipo, presence: true
  # validates :nome, uniqueness: {scope: :tipo}
  validate :check_uniqueness_name_and_type

  TIPO = [ "Masculina", "Feminina", "Mista"]

  def check_uniqueness_name_and_type
    mods = []
    if !self.new_record?
      mods = Modalidade.where("id != ? AND lower(nome) = ? AND tipo = ?", self.id, self.nome.downcase, self.tipo)
    elsif self.nome.present? && self.tipo.present?
      mods = Modalidade.where('lower(nome) = ? AND tipo = ?', self.nome.downcase, self.tipo)
    end

    if mods.any?
      self.errors.add(:base, "Já existe uma modalidade com esse nome e tipo.")
    end
  end
end
