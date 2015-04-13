class Evento < ActiveRecord::Base
  has_many :evento_modalidades, dependent: :destroy
  has_many :modalidades, through: :evento_modalidades

  attr_accessible :ano, :nome

  validates :ano, presence: true
  validates :nome, presence: true
  validates :nome, uniqueness: {scope: :ano}
end
