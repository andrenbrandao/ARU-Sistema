class EventoRepublica < ActiveRecord::Base
  belongs_to :evento
  belongs_to :republica
  attr_accessible :agregado

  validates :evento, presence: true
  validates :agregado, uniqueness: {scope: [:evento_id, :republica_id]}
  validates :republica, presence: true
  validates :agregado, presence: true
end
