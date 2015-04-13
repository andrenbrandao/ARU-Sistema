class Modalidade < ActiveRecord::Base
  has_many :evento_modalidades, dependent: :destroy
  has_many :eventos, through: :evento_modalidades

  attr_accessible :nome, :tipo

  validates :nome, presence: true
  validates :tipo, presence: true
  validates :nome, uniqueness: {scope: :tipo}

  TIPO = [ "masc", "fem", "mist"]
end
