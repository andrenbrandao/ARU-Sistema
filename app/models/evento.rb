class Evento < ActiveRecord::Base
  has_many :evento_modalidades, dependent: :destroy
  has_many :modalidades, through: :evento_modalidades
  has_many :evento_moradores, dependent: :destroy
  has_many :moradores, through: :evento_moradores

  attr_accessible :ano, :nome

  validates :ano, presence: true
  validates :nome, presence: true
  validates :nome, uniqueness: {scope: :ano}
end
